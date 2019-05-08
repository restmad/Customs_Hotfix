
WHENEVER SQLERROR EXIT FAILURE ROLLBACK;

CREATE OR REPLACE PACKAGE china_customs_utils AS


   FUNCTION Get_Resource_Actuals
  (p_resource_user_id   IN NUMBER,
   p_period_type_id     IN NUMBER,
   p_work_item_set_id IN STRING)
  RETURN NUMBER;

  PRAGMA RESTRICT_REFERENCES(Get_Resource_Actuals, WNDS, WNPS);
  
  
   FUNCTION Get_OrgUnit_Path
  (p_org_unit_id   IN NUMBER)
  RETURN VARCHAR2;

  PRAGMA RESTRICT_REFERENCES(Get_OrgUnit_Path, WNDS, WNPS);
  
  FUNCTION Get_Project_Schedule_Efforts
   (p_project_id  IN NUMBER)
  RETURN NUMBER;

  PRAGMA RESTRICT_REFERENCES(Get_Project_Schedule_Efforts, WNDS, WNPS);
  
  FUNCTION Get_Project_Remaining_Efforts
   (p_project_id  IN NUMBER)
  RETURN NUMBER;

  PRAGMA RESTRICT_REFERENCES(Get_Project_Remaining_Efforts, WNDS, WNPS);


END china_customs_utils;
/


SET ARRAYSIZE 2;
SET PAGESIZE 2000;

SHOW ERRORS PACKAGE china_customs_utils;
