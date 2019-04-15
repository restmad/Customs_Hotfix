WHENEVER SQLERROR EXIT FAILURE ROLLBACK;

CREATE OR REPLACE PACKAGE BODY china_customs_utils AS


---------------------------------------------------------------------------
-- Function will the total actuals to date for the special work item set that a
-- given resource has on his/her timesheets for the current and
-- previous time period for a given period type.

  FUNCTION Get_Resource_Actuals
---------------------------------------------------------------------------
        (p_resource_user_id   IN NUMBER,
         p_period_type_id     IN NUMBER,
         p_work_item_set_id IN STRING)
        RETURN NUMBER
  IS

l_total number;

BEGIN

    SELECT SUM(ae.actual_effort) actuals_to_date
    INTO   l_total
    FROM   tm_time_sheets tts2,
           tm_time_sheet_lines tsl,
           tm_actuals act,
           tm_actuals_effort ae,
           rsc_resources r
    WHERE  (tsl.work_item_type, tsl.work_item_id) IN
        (SELECT distinct tsl.work_item_type, tsl.work_item_id
         FROM
          tm_time_sheet_lines tsl,
          tm_time_sheets tts,
          ktmg_periods p,
          rsc_resources r
         WHERE 
          p.period_type_id = p_period_type_id
         AND  tts.period_id = p.period_id
         AND  tts.status_code != 5 -- cancelled
         AND  tts.resource_id = r.resource_id
         AND  r.user_id = p_resource_user_id
         AND tsl.work_item_set_id = p_work_item_set_id
         AND  tsl.time_sheet_id = tts.time_sheet_id)
    AND    act.time_sheet_line_id = tsl.time_sheet_line_id
    AND    act.totals_flag = 'Y'
    AND    ae.actuals_id = act.actuals_id
    AND    tts2.time_sheet_id = tsl.time_sheet_id
    AND    tts2.resource_id = r.resource_id
    AND    r.user_id = p_resource_user_id
    AND    tts2.status_code != 5; -- cancelled

    return(l_total);

END Get_Resource_Actuals;


FUNCTION Get_OrgUnit_Path
  (p_org_unit_id   IN NUMBER)
  RETURN VARCHAR2
  
  IS
  
  l_path VARCHAR2(300);
  
BEGIN
	select listagg(org_unit_name, '->') within group (order by rownum) into l_path from krsc_org_units start with  ORG_UNIT_ID = p_org_unit_id Connect By  Prior PARENT_ORG_UNIT_ID = ORG_UNIT_ID;
  
  return l_path;

END Get_OrgUnit_Path;

END china_customs_utils;
/


SET ARRAYSIZE 2;
SET PAGESIZE 2000;

SHOW ERRORS PACKAGE BODY china_customs_utils;

