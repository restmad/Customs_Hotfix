/*
 * SCRIPT      : ppm_object_storage_952_1.sql
 *
 * AUTHOR      : Dong, Zhang
 * PURPOSE     : US#274482
 */

SET SERVEROUTPUT ON
WHENEVER SQLERROR EXIT FAILURE ROLLBACK

BEGIN
    DBMS_OUTPUT.put_line ('File ppm_object_storage_952_1.sql started at ' || TO_CHAR (CURRENT_DATE, 'MON-DD-YYYY HH24:MI:SS') );

    ppm_db_utils.create_table('PPM_OBJECT_STORAGE','CREATE TABLE PPM_OBJECT_STORAGE(
    FILE_PATH VARCHAR2(200 CHAR) NOT NULL,
    FILE_STRING BLOB)');

    DBMS_OUTPUT.put_line ('File ppm_object_storage_952_1.sql completed at ' || TO_CHAR (CURRENT_DATE, 'MON-DD-YYYY HH24:MI:SS') );
END;
/
