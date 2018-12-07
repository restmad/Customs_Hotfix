
create or replace force view cc_resources_by_month_v as
SELECT  /*+ RULE */ 
        a.RESOURCE_FULL_NAME, 
        a.RESOURCE_USER_ID, 
        a.work_item_set_id,
        a.long_name, 
        a.fiscal_period_id, 
        a.ACTUAL_TIME_CURRENT, 
        CHINA_CUSTOMS_UTILS.Get_Resource_Actuals(a.RESOURCE_USER_ID,     1, a.work_item_set_id) ACTUALS_TO_DATE 
FROM 
(SELECT ku.full_name RESOURCE_FULL_NAME,
         r.user_id AS RESOURCE_USER_ID,
         ttsl.work_item_set_id work_item_set_id,
         fp.long_name,
         fp.fiscal_period_id,
         SUM (ae.ACTUAL_effort) ACTUAL_TIME_CURRENT
    FROM KNTA_USERS ku,
         tm_actuals ta,
         tm_actuals_effort ae,
         TM_TIME_SHEET_LINES ttsl,
         TM_TIME_SHEETS tts,
         rsc_resources r,
         KTMG_PERIODS tp,
         ppm_fiscal_periods_nls fp
   WHERE     TP.START_DATE < fp.end_date
         AND TP.END_DATE >= fp.start_date
         AND tts.period_id = tp.period_id
         AND tts.status_code != 5                                 -- cancelled
         AND ttsl.time_sheet_id = tts.time_sheet_id
         AND ttsl.work_item_type IN ('TASK', 'PROJECT')
         AND ta.time_sheet_line_id = ttsl.time_sheet_line_id
         AND ta.totals_flag = 'Y'
         AND ae.actuals_id = ta.actuals_id
         AND tts.resource_id = r.resource_id
         AND ku.user_id = r.user_id
         AND FP.PERIOD_TYPE = 4
         AND TP.PERIOD_TYPE_ID = 1
GROUP BY ttsl.work_item_set_id,
         ku.full_name,
         r.USER_ID,
         fp.fiscal_period_id,
         fp.long_name) a;
        
