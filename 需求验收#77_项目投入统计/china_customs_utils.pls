
WHENEVER SQLERROR EXIT FAILURE ROLLBACK;

CREATE OR REPLACE PACKAGE china_customs_utils AS


   FUNCTION Get_Resource_Actuals
  (p_resource_user_id   IN NUMBER,
   p_period_type_id     IN NUMBER,
   p_work_item_set_id IN STRING)
  RETURN NUMBER;

  PRAGMA RESTRICT_REFERENCES(Get_Resource_Actuals, WNDS, WNPS);


END china_customs_utils;
/


SET ARRAYSIZE 2;
SET PAGESIZE 2000;

SHOW ERRORS PACKAGE china_customs_utils;
