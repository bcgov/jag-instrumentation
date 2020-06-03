index="prod_web" (sourcetype="access_combined" OR sourcetype="access_combined_wcookie") host IN ("seethe.bcgov" "simmer.bcgov" "stew.bcgov" "churn.bcgov" "parch.bcgov")
| table _time root config other status
| eval application=root
| eval application=if(like(application, "% HTTP"), "other_apps", application) 
| eval config=case(
    in(lower(application), "ceis", "coaf", "crc", "cso-2", "cso", "dfweb", "ecrc", "essa", "filingassistant", "jpi", "lra", "opra", "psso"), "JBoss - JUSTIN",
    in(lower(application), "jrccordsapiwrapper", "autoefile", "carmaws", "ccd", "cdds-3", "cdds", "crrpservice", "cso-autoefile-batch-run", "cso2jpiws", "csoextws", "csojm", "csows", "dfwebws", "docUploader", "essaws", "fams", "iris-2", "iris-4", "iris", "pac", "pacws", "phis", "vipsws", "vista"), "JBoss - Justice and Attorney General", 
    like(config, "%"), config, 
    true(), "other_configs"
    ) 
| eval config=if((lower(application)="12cforms2" AND config="other_configs"), "other_oraforms", config) 
| eval duration=(round(other/1000000)) 
| eval config=trim(config)
| eval application=trim(application)
| fields application config duration status 
| `jag_proxy_human_readable`
| fields application config duration status 
| eval appName=if(application="Oracle Forms 12",trim(application.": ".config),trim(application))
| eventstats 
    count(eval(isnotnull(status))) AS totalCount 
    count(eval(duration > 30)) AS speedCount
    count(eval(status > 500)) AS gradeCount
    by appName application config
| fillnull totalCount speedCount gradeCount value=0
| eval speedPercent=if(speedCount=0,100, round(100-((speedCount/totalCount)*100),2)) 
| eval gradePercent=if(gradeCount=0,100, round(100-((gradeCount/totalCount)*100),2)) 
| fillnull speedPercent gradePercent duration totalCount value=0
| fields application config appName speedPercent gradePercent
| eval icon=case(
    (speedPercent > 98 AND gradePercent > 98), "check-circle",
    (speedPercent >= 98 AND speedPercent > 96) OR (gradePercent >= 98 AND gradePercent > 96), "exclamation-triangle",
    (speedPercent <= 96 AND speedPercent > 0) AND (gradePercent <= 96 AND gradePercent > 0), "times-circle",
    1=1,NULL())
| eval color=case(
    (speedPercent > 98 AND gradePercent > 98), "#53A051",
    (speedPercent >= 98 AND speedPercent > 96) OR (gradePercent >= 98 AND gradePercent > 96), "#F58F39",
    (speedPercent <= 96 AND speedPercent > 0) AND (gradePercent <= 96 AND gradePercent > 0), "#DC4E41",
    1=1,"#FFFFFF")
| fields application config appName icon color speedPercent gradePercent _time
| eval oneDaySpeedPercent=if(((_time < relative_time(now(), "-0d@d" )) AND _time > (relative_time(now(), "-1d@d" ))), speedPercent,  NULL())
| eval sevenDaySpeedPercent=if(((_time < relative_time(now(), "-0d@d" )) AND _time > (relative_time(now(), "-7d@d" ))), speedPercent,  NULL()) 
| eval thirtyDaySpeedPercent=if(((_time < relative_time(now(), "-0d@d" )) AND _time > (relative_time(now(), "-30d@d" ))), speedPercent,  NULL())
| eval oneDayGradePercent=if(((_time < relative_time(now(), "-0d@d" )) AND _time > (relative_time(now(), "-1d@d" ))), gradePercent,  NULL())
| eval sevenDayGradePercent=if(((_time < relative_time(now(), "-0d@d" )) AND _time > (relative_time(now(), "-7d@d" ))), gradePercent,  NULL()) 
| eval thirtyDayGradePercent=if(((_time < relative_time(now(), "-0d@d" )) AND _time > (relative_time(now(), "-30d@d" ))), gradePercent,  NULL())
| stats 
    avg(oneDaySpeedPercent) AS "oneDaySpeed"
    avg(sevenDaySpeedPercent) AS "sevenDaySpeed"
    avg(thirtyDaySpeedPercent) AS "thirtyDaySpeed"
    avg(oneDayGradePercent) AS "oneDayGrade"
    avg(sevenDayGradePercent) AS "sevenDayGrade"
    avg(thirtyDayGradePercent) AS "thirtyDayGrade"
    BY appName
| eval oneDaySpeed=round(oneDaySpeed,2)
| eval sevenDaySpeed=round(sevenDaySpeed,2)
| eval thirtyDaySpeed=round(thirtyDaySpeed,2)
| eval oneDayGrade=round(oneDayGrade,2)
| eval sevenDayGrade=round(sevenDayGrade,2)
| eval thirtyDayGrade=round(thirtyDayGrade,2)
| eval oneSevenThirtySpeed=oneDaySpeed."% / ".sevenDaySpeed."% / ".thirtyDaySpeed."%"
| eval oneSevenThirtyGrade=oneDayGrade."% / ".sevenDayGrade."% / ".thirtyDayGrade."%"