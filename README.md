Customs Hotfix
==========================

## Deploy a Hotfix with kDeploy.sh
A new parameter was added to kDeploy when deploying Hotfix:
    
    kDeploy.sh -hotfix <DEPLOYMENT_HOTFIX>
    
<DEPLOYMENT_HOTFIX> is the Hotfix bundle name.

## For example:
If bundle name is 951-HOTFIX-EXCEL.jar, the corresponding deployment command is 
    
    sh kDeploy.sh -hotfix 951-HOTFIX-EXCEL.jar
    

## Steps:
    1. Stop server (kStop.sh -now)
    2. run sh kDeploy.sh -hotfix 951-HOTFIX-EXCEL.jar
    3. run sh kDeploy.sh -hotfix 951-HOTFIX-EXCEL.jar

    