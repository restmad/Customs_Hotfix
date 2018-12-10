create or replace force view cc_tasks_progress_by_month_v as
SELECT main.*, tk.work_plan_id, round(PERC_COMPLETE, 4)||'%' complete
  FROM (  SELECT ttslv.work_item_set project_name,
                    ttslv.work_item task_name,
                    ttslv.description,
                    ttslv.work_item_type_code type_code,
                    ttslv.work_item_set_id project_id,
                    ttslv.work_item_id task_id,
                    ttslv.long_name,
                    ttslv.fiscal_period_id,
                    ktmg_perf.Work_Item_Actuals (work_item_id,
                                                 work_item_type_code)
                       ACTUALS_TO_DATE,
                    SUM (
                       ttslv.actual_effort)
                       actual_time_current
               FROM (SELECT tp.period_id tp_period_id,
                            ae.actual_effort,
                            fp.fiscal_period_id,
                            FP.LONG_NAME,
                            tsl.time_sheet_line_id,
                            tsl.time_sheet_id,
                            tsl.work_item_id,
                            tsl.work_item_type work_item_type_code,
                            lu1.meaning AS work_item_type,
                            NVL (kproj.task_name, 'Deleted') AS work_item,
                            kproj.project_name work_item_set,
                            tsl.work_item_set_id,
                            (SELECT pm_utils.get_task_path (kproj.task_id)
                               FROM DUAL)
                               description,
                            tsl.state
                       FROM tm_project_tasks_lite_v kproj,
                            tm_time_sheet_lines tsl,
                            tm_time_sheets ts,
                            ktmg_periods tp,
                            ppm_fiscal_periods fp,
                            tm_actuals ta,
                            tm_actuals_effort ae,
                            ktmg_period_types pt,
                            knta_lookups lu1
                      WHERE     
                            tsl.work_item_type = 'TASK'
                            AND kproj.task_id = tsl.work_item_id
                            AND ts.time_sheet_id = tsl.time_sheet_id
                            AND lu1.lookup_type = 'TMG - Work Item Types'
                            AND lu1.lookup_code = tsl.work_item_type
                            and TP.START_DATE < fp.end_date
                            and TP.END_DATE >= fp.start_date
                            AND tsl.time_sheet_id = ts.time_sheet_id
                            AND ts.period_id = tp.period_id
                            AND ta.time_sheet_line_id = tsl.time_sheet_line_id
                            AND ta.totals_flag = 'Y'
                            AND ts.status_code != 5               -- cancelled
                            AND ae.actuals_id = ta.actuals_id
                            and FP.PERIOD_TYPE = 4
                            and TP.PERIOD_TYPE_ID = 1
                            and TP.period_type_id = pt.period_type_id
                            ) ttslv
           GROUP BY ttslv.work_item_set,
                    ttslv.work_item,
                    ttslv.description,
                    ttslv.work_item_type_code,
                    ttslv.work_item_set_id,
                    ttslv.work_item_id,
                    ttslv.fiscal_period_id,
                    ttslv.long_name) main,
       WP_TASKS tk,
       WP_TASK_ACTUALS ta
 WHERE tk.TASK_ACTUALS_ID = ta.actuals_id AND main.task_id = tk.task_id;