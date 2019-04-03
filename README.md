Customs Hotfix
==========================

## Deploy a Hotfix with kDeploy.sh
A new parameter was added to kDeploy when deploying Hotfix:
    
    kDeploy.sh -hotfix <DEPLOYMENT_HOTFIX>
    
<DEPLOYMENT_HOTFIX> is the Hotfix bundle name.

## For example:
If bundle name is 951-HOTFIX-EXCEL.jar, the corresponding deployment command is 
    
    sh kDeploy.sh -hotfix 951-HOTFIX-EXCEL.jar
    
If you meet file conflict when Deploying hotfix, please use below command. Be careful, it will overwrite the existing file.
    
    sh kDeploy.sh -legacy-hotfix 951-HOTFIX-EXCEL.jar
    

## Deploy hotfix Steps:
    1. Stop server (kStop.sh -now)
    2. run sh kDeploy.sh -hotfix 951-HOTFIX-EXCEL.jar                                 (需求验收#30_导入项目计划)
    3. run sh kDeploy.sh -hotfix 951-HOTFIX-TAILOR.jar                                (需求验收#40_制定裁剪报告)
    4. run sh kDeploy.sh -hotfix 951-HOTFIX-RISK_TIMESHEET.jar                        (需求验收#20_个人周报)
    5. run sh kDeploy.sh -legacy-hotfix  951-HOTFIX-QCIM1L10000-QCCR1L10000-V2.jar    (需求验收#12_管理信息)
    6. run sh kDeploy.sh -legacy-hotfix  951-HOTFIX-QCIM1L10002-V4.jar                (需求验收#37_基线管理)
    7. run sh kDeploy.sh -i PluginQuality                                             (需求验收#69_测试管理度量)
    8. run sh kDeploy.sh -i PluginQualityVPQ                                          (需求验收#69_测试管理度量)
	9. run sh kDeploy.sh -hotfix 951-HOTFIX-QCIM1L270160-QCCR1L270160.jar             (object_storage 暂缓)
    10. run sh kDeploy.sh -hotfix 951-HOTFIX-FORBID_ATTACHMENT.jar                    (禁止上传， 注意：只能部署在对外接入网)
	11. run sh kDeploy.sh -hotfix 951-HOTFIX-MODULE_STATISTICS.jar                    (需求验收#116_模块统计)
	12. run sh kDeploy.sh -legacy-hotfix 951-HOTFIX-TINY_PROJECT-V2.jar               (需求管理#极简项目)
	13. run sh kDeploy.sh -i ALM                                                      (需求验收#124_ALM集成)
	14. run sh kDeploy.sh -hotfix 951-HOTFIX-MILESTONE.jar                            (项目集milestone问题)
    15. run sh kDeploy.sh -legacy-hotfix 951-HOTFIX-CALENDAR-V1.jar                   (需求管理#日历图)
	16. run sh kDeploy.sh -legacy-hotfix 951-HOTFIX-DEFAULT_EFFORTS-V1.jar    		  (需求管理#工时默认值)


## Run Script Steps:
	1. 执行 china_customs_utils.pls            (需求验收#77_项目投入统计)
	2. 执行 china_cusotms_utils.plb            (需求验收#77_项目投入统计)
	3. 执行 cc_resources_in_project_v.sql      (需求验收#77_项目投入统计)
	4. 执行 PM_BASELINES_APPROVE_STATUS.sql    (需求验收#37_基线管理)
	5. 执行 cc_tasks_progress_v.sql			   (需求验收#74_项目周报)
	6. 执行 ppm_object_storage_952_1.sql       (object_storage 暂缓)
	7. 执行 cc_tasks_progress_by_month.sql     (需求验收#74_项目周报)
	8. 执行 cc_resources_by_month_v.sql        (需求验收#77_项目投入统计)
	9. 执行 PPM_MODULE_STATISTICS.sql          (需求验收#116_模块统计)
	10.执行 knta_services_nls_module_statistics.sql (需求验收#116_模块统计)
	11.执行 WP_TASKS.sql        			    (需求验收#30_导入项目计划)
	

## Server.conf

    #com.kintana.core.server.OBJECT_STORAGE_ADAPTER_CLASS=com.kintana.core.util.ObjectStorageUtils  (注意要DMS配置要用JDBC方式)
	com.kintana.core.server.ENABLE_IMPORT_EXPORT_EXCEL_IN_WORKPLAN=true	
	

    