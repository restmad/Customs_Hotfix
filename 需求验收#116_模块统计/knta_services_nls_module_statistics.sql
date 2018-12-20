
SET SERVEROUTPUT ON
WHENEVER SQLERROR EXIT FAILURE ROLLBACK

DECLARE
	SCRIPT_NAME CONSTANT VARCHAR2(50) := 'knta_services_nls_module_statistics.sql';
	l_exists   BOOLEAN := TRUE;
    l_dummy    NUMBER;
BEGIN
	DBMS_OUTPUT.PUT_LINE('File ' || SCRIPT_NAME || ' started at ' || TO_CHAR(CURRENT_DATE, 'MON-DD-YYYY HH24:MI:SS'));
	
	BEGIN
		l_exists := TRUE;
		SELECT 1
		INTO l_dummy
		FROM DUAL
		WHERE EXISTS (SELECT 1 FROM knta_services_nls WHERE reference_code = '_MODULE_STATISTICS_SERVICE');
	EXCEPTION
		WHEN NO_DATA_FOUND
		THEN
			l_exists := FALSE;
	END;
	
	IF (NOT l_exists)
	THEN
		INSERT INTO KNTA_SERVICES_NLS
		(SERVICE_ID,
		  ACCELERATOR_ID,
		  JAVA_CLASS,
		  USE_SERVICE_CONTROLLER,
		  SERVICE_NAME,
		  RUN_IN_SEPARATE_THREAD,
		  LAST_RUN_DATE,
		  DEFINITION_LANGUAGE,
		  REFERENCE_CODE,
		  JOB_CLASS,
		  HANDLER_NAME,
		  DEFAULT_CRON_EXPRESSION,
		  CRON_EXPRESSION,
		  SERVICE_ENABLED,
		  TARGET_QUEUE,
		  CURRENT_INTERVAL,
		  DEFAULT_INTERVAL,
		  LAST_RUN_INSTANCE_NAME)
		VALUES
		( 90000,
		  null,
		  'com.mercury.itg.core.module.statistics.ModuleStatisticsService',
		  'N',
		  'Module Statistics Service',
		  'Y',
		  to_date('29-10-2012 23:30:30', 'dd-mm-yyyy hh24:mi:ss'),
		  'AMERICAN',
		  '_MODULE_STATISTICS_SERVICE',
		  'com.mercury.itg.core.scheduler.service.impl.GenericJob' ,
		  'genericHandler' ,
		  null,
		  null,
		  'N', 
		  'ppmLightServiceQueue',
		  86400000,
		  86400000,
		  NULL); 
	END IF;
	
	DBMS_OUTPUT.PUT_LINE('File ' || SCRIPT_NAME || ' completed at ' || TO_CHAR(CURRENT_DATE, 'MON-DD-YYYY HH24:MI:SS'));
END;

commit;