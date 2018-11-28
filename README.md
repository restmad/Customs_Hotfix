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
    5. run sh kDeploy.sh -legacy-hotfix 951-HOTFIX-QCIM1L10000-QCCR1L10000-V1.jar     (需求验收#12_管理信息)
    6. run sh kDeploy.sh -legacy-hotfix 951-HOTFIX-QCIM1L10002-V2.jar                 (需求验收#37_基线管理)
    7. run sh kDeploy.sh -i PluginQuality                                             (需求验收#69_测试管理度量)
    8. run sh kDeploy.sh -i PluginQualityVPQ                                          (需求验收#69_测试管理度量)
    


## Run Script Steps:
	1. 执行 china_customs_utils.pls            (需求验收#77_项目投入统计)
	2. 执行 china_cusotms_utils.plb            (需求验收#77_项目投入统计)
	3. 执行 cc_resources_in_project_v.sql      (需求验收#77_项目投入统计)
	4. 执行 PM_BASELINES_APPROVE_STATUS.sql    (需求验收#37_基线管理)

    