
create or replace force view cc_resources_in_project_v as
SELECT  /*+ RULE */ 
        a.RESOURCE_FULL_NAME, 
        a.RESOURCE_USER_ID, 
        a.work_item_set_id,
        a.period_type_name, 
        a.period_type_id, 
        a.ACTUAL_TIME_CURRENT, 
        a.ACTUAL_TIME_PREVIOUS, 
        CHINA_CUSTOMS_UTILS.Get_Resource_Actuals(a.RESOURCE_USER_ID,     a.period_type_id, a.work_item_set_id) ACTUALS_TO_DATE 
FROM 
(SELECT ku.full_name RESOURCE_FULL_NAME, 
        r.user_id as RESOURCE_USER_ID,
        ttsl.work_item_set_id work_item_set_id, 
        pt.period_type_name, 
        pt.period_type_id, 
        sum(decode(tts.period_id, tpc.period_id, ae.ACTUAL_effort,0)) 
                ACTUAL_TIME_CURRENT, 
        sum(decode(tts.period_id, tpc.period_id, 0, ae.ACTUAL_effort)) 
                ACTUAL_TIME_PREVIOUS 
   FROM KNTA_USERS ku, 
        tm_actuals ta,
        tm_actuals_effort ae, 
        TM_TIME_SHEET_LINES ttsl, 
        TM_TIME_SHEETS tts,
        rsc_resources r, 
        KTMG_PERIODS tp, 
        KTMG_PERIOD_TYPES pt, 
        KTMG_PERIODS tpc 
WHERE   tpc.start_date < CURRENT_DATE 
 AND    tpc.end_date >= CURRENT_DATE 
 AND    tpc.period_type_id = pt.period_type_id 
 AND    tp.period_type_id = tpc.period_type_id 
 AND    (tp.period_id = tpc.period_id 
   OR    tp.seq = tpc.seq - 1) 
 AND    tts.period_id = tp.period_id 
 AND    tts.status_code != 5 -- cancelled 
 AND    ttsl.time_sheet_id = tts.time_sheet_id 
 AND    ttsl.work_item_type in ('TASK', 'PROJECT')
 AND    ta.time_sheet_line_id = ttsl.time_sheet_line_id 
 AND    ta.totals_flag = 'Y'
 and    ae.actuals_id = ta.actuals_id
 and    tts.resource_id = r.resource_id
 AND    ku.user_id = r.user_id 
GROUP BY 
        ttsl.work_item_set_id,
        ku.full_name, 
        r.USER_ID, 
        pt.period_type_name, 
        pt.period_type_id) a;
        
