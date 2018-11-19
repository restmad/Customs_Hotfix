
CREATE OR REPLACE FORCE VIEW cc_resource_efforts_in_task_v (full_name, project_name, task_name, description,  type_code,  project_id,  task_id, period_type_name,                                                                     
period_type_id, actual_time_current,  actual_time_previous)
AS
    SELECT   ttslv.full_name, ttslv.work_item_set project_name, ttslv.work_item task_name,
            ttslv.description, ttslv.work_item_type_code type_code,
            ttslv.work_item_set_id project_id, ttslv.work_item_id task_id,
            ttslv.period_type_name, ttslv.period_type_id,
            SUM (DECODE (ttslv.tp_period_id,
                         ttslv.period_id, ttslv.actual_effort,
                         0
                        )
                ) actual_time_current,
            SUM (DECODE (ttslv.tp_period_id,
                         ttslv.period_id, 0,
                         ttslv.actual_effort
                        )
                ) actual_time_previous
       FROM (

             SELECT ku.full_name full_name, tp.period_id tp_period_id, ae.actual_effort,
                    pt.period_type_name, pt.period_type_id, tpc.period_id,
                    tsl.time_sheet_line_id, tsl.creation_date, tsl.created_by,
                    tsl.last_update_date, tsl.last_updated_by,
                    tsl.time_sheet_id, tsl.work_item_id,
                    tsl.work_item_type work_item_type_code,
                    lu1.meaning AS work_item_type,
                    NVL (kproj.task_name, 'Deleted') AS work_item,
                    kproj.project_name work_item_set, tsl.work_item_set_id,
                    (SELECT pm_utils.get_task_path (kproj.task_id)
                       FROM DUAL) description,                    
                    --kproj.description,
                    tsl.state
             FROM   tm_project_tasks_lite_v kproj,
                    tm_time_sheet_lines tsl,
                    tm_time_sheets ts,
                    ktmg_periods tp,
                    ktmg_periods tpc,
                    tm_actuals ta,
                    tm_actuals_effort ae,
                    ktmg_period_types pt,
                    rsc_resources rs,
                    knta_users ku,
                    knta_lookups lu1
              WHERE 
        --tsl.work_item_id = wav.work_item_id(+)
                --AND tsl.work_item_type = wav.work_item_type_code(+)
                tsl.work_item_type in ('TASK', 'PROJECT')
                AND kproj.task_id = tsl.work_item_id
                AND ts.time_sheet_id = tsl.time_sheet_id
                AND lu1.lookup_type = 'TMG - Work Item Types'
                AND lu1.lookup_code = tsl.work_item_type
                AND tpc.start_date < CURRENT_DATE
                AND tpc.end_date >= TRUNC (CURRENT_DATE)
                AND tp.period_type_id = tpc.period_type_id
                AND (tp.period_id = tpc.period_id OR tp.seq = tpc.seq - 1)
                AND tpc.period_type_id = pt.period_type_id
                AND tsl.time_sheet_id = ts.time_sheet_id
                AND ts.period_id = tp.period_id
                AND ta.time_sheet_line_id = tsl.time_sheet_line_id
                AND ta.totals_flag = 'Y'
                AND ts.status_code != 5                           -- cancelled
                AND ae.actuals_id = ta.actuals_id
                AND rs.user_id = ku.user_id
                AND ts.resource_id = rs.resource_id
           ) ttslv
   GROUP BY ttslv.full_name,
            ttslv.work_item_set,
            ttslv.work_item,
            ttslv.description,
            ttslv.work_item_type_code,
            ttslv.work_item_set_id,
            ttslv.work_item_id,
            ttslv.period_type_name,
            ttslv.period_type_id;
    
   

