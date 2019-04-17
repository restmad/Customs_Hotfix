
SET SERVEROUTPUT ON SIZE 999999;
WHENEVER SQLERROR EXIT FAILURE ROLLBACK;

DECLARE
  SCRIPT_NAME CONSTANT VARCHAR2(50) := 'update_ALM_for_chinese.sql';
  l_status_fixed_id NUMBER;
  l_exists NUMBER := 0;
  
BEGIN

  DBMS_OUTPUT.PUT_LINE('Start running ' || SCRIPT_NAME || ' at ' || TO_CHAR(CURRENT_DATE, 'MON-DD-YYYY HH24:MI:SS'));
  
	update kcrt_statuses_loc set status_name = '新建'  where status_name  = '新';
	update kcrt_statuses_loc set status_name = '拒绝'  where status_name  = '已拒绝';
	
	select count(*) into l_exists from kcrt_statuses_loc where status_name  = '已修正';
	IF l_exists = 0 THEN 
		select status_id into l_status_fixed_id from kcrt_statuses_nls where STATUS_NAME = 'Fixed';
		insert into kcrt_statuses_loc(id, entity_id, lang_id, status_name) values(KCRT_STATUSES_LOC_S.nextval, l_status_fixed_id, 'SIMPLIFIED CHINESE', '已修正');
	END IF;
	
 EXCEPTION WHEN NO_DATA_FOUND 
 THEN
     DBMS_OUTPUT.PUT_LINE('no data found');

    
  DBMS_OUTPUT.PUT_LINE('Completed running script ' || script_name || ' at ' || to_char(current_date, 'MON-DD-YYYY HH24:MI:SS'));
  
END;
/
commit;