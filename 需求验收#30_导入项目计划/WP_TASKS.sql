/*
 * AUTHOR:      Elva Zhu
 * PURPOSE:     add column to store external UID while this task is imported from other application, for example excel
 * Script:	WP_TASKS_952_1.sql		
 */


SET SERVEROUTPUT ON SIZE 999999;

WHENEVER SQLERROR EXIT FAILURE ROLLBACK;

DECLARE
    SCRIPT_NAME CONSTANT VARCHAR2(100) := 'WP_TASKS_952_1.sql';
	l_sql_stmt  VARCHAR2(20000);
BEGIN

    DBMS_OUTPUT.PUT_LINE('Start running ' || SCRIPT_NAME || ' at ' || TO_CHAR(CURRENT_DATE, 'MON-DD-YYYY HH24:MI:SS'));

   IF (ppm_db_utils.check_if_column_exists ('WP_TASKS', 'EXTERNAL_UID') <> 1) THEN
        l_sql_stmt := 'ALTER TABLE WP_TASKS ADD(EXTERNAL_UID VARCHAR2(100 CHAR))';
        EXECUTE IMMEDIATE l_sql_stmt;
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('Complete running ' || SCRIPT_NAME || ' at ' || TO_CHAR(CURRENT_DATE, 'MON-DD-YYYY HH24:MI:SS'));

END;
/