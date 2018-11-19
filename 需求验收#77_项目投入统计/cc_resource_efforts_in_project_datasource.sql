SELECT /*+ PUSH_PRED(v) */   resource_full_name RESOURCE_FULL_NAME, actual_time_current ACTUAL_TIME_CURRENT, actual_time_previous ACTUAL_TIME_PREVIOUS, actuals_to_date ACTUALS_TO_DATE
FROM cc_resources_in_project_v v
WHERE 1=1
--This section comes from the filter fields
AND work_item_set_id = [P.WORK_ITEM_SET_ID]
--End section from the filter fields