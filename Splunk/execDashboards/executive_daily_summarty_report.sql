| inputcsv dailyJAGExecutiveBreakdown.csv
| eval dateEpoch=strptime(date,"%Y/%m/%d")
| eval today=relative_time(now(), "-0d@d")
| eval dataAgeDays=round((today-dateEpoch)/86400,0)
| eval oneDayTotalCount=if((dataAgeDays <= 1), totalCount, NULL())
| eval twoDayTotalCount=if((dataAgeDays >= 1 AND dataAgeDays <= 2), totalCount, NULL())
| eval sevenDayTotalCount=if((dataAgeDays >= 1 AND dataAgeDays <= 7), totalCount, NULL())
| eval thirtyDayTotalCount=if((dataAgeDays >= 1 AND dataAgeDays <= 30 ), totalCount, NULL())
| eval oneDaySpeedCount=if((dataAgeDays <= 1), speedCount, NULL())
| eval twoDaySpeedCount=if((dataAgeDays >= 1 AND dataAgeDays <= 2), speedCount, NULL())
| eval sevenDaySpeedCount=if((dataAgeDays >= 1 AND dataAgeDays <= 7), speedCount, NULL())
| eval thirtyDaySpeedCount=if((dataAgeDays >= 1 AND dataAgeDays <= 30 ), speedCount, NULL())
| eval oneDayGradeCount=if((dataAgeDays <= 1), gradeCount, NULL())
| eval twoDayGradeCount=if((dataAgeDays >= 1 AND dataAgeDays <= 2), gradeCount, NULL())
| eval sevenDayGradeCount=if((dataAgeDays >= 1 AND dataAgeDays <= 7), gradeCount, NULL())
| eval thirtyDayGradeCount=if((dataAgeDays >= 1 AND dataAgeDays <= 30 ), gradeCount, NULL())
| eval oneDayTotalTime=if((dataAgeDays <= 1), durationTotal, NULL())
| eval twoDayTotalTime=if((dataAgeDays >= 1 AND dataAgeDays <= 2), durationTotal, NULL())
| eval sevenDayTotalTime=if((dataAgeDays >= 1 AND dataAgeDays <= 7), durationTotal, NULL())
| eval thirtyDayTotalTime=if((dataAgeDays >= 1 AND dataAgeDays <= 30 ), durationTotal, NULL())
| eval oneDayGradeTime=if((dataAgeDays <= 1), gradeTime, NULL())
| eval twoDayGradeTime=if((dataAgeDays >= 1 AND dataAgeDays <= 2), gradeTime, NULL())
| eval sevenDayGradeTime=if((dataAgeDays >= 1 AND dataAgeDays <= 7), gradeTime, NULL())
| eval thirtyDayGradeTime=if((dataAgeDays >= 1 AND dataAgeDays <= 30 ), gradeTime, NULL())
| eval oneDaySpeedTime=if((dataAgeDays <= 1), slowTime, NULL())
| eval twoDaySpeedTime=if((dataAgeDays >= 1 AND dataAgeDays <= 2), slowTime, NULL())
| eval sevenDaySpeedTime=if((dataAgeDays >= 1 AND dataAgeDays <= 7), slowTime, NULL())
| eval thirtyDaySpeedTime=if((dataAgeDays >= 1 AND dataAgeDays <= 30 ), slowTime, NULL())
| eval oneDayWastedTime=if((dataAgeDays <= 1), wastedTime, NULL())
| eval twoDayWastedTime=if((dataAgeDays >= 1 AND dataAgeDays <= 2), wastedTime, NULL())
| eval sevenDayWastedTime=if((dataAgeDays >= 1 AND dataAgeDays <= 7), wastedTime, NULL())
| eval thirtyDayWastedTime=if((dataAgeDays >= 1 AND dataAgeDays <= 30 ), wastedTime, NULL())
| stats 
    sum(oneDaySpeedCount) AS "oneDaySpeed"
    sum(twoDaySpeedCount) AS "twoDaySpeed"
    sum(sevenDaySpeedCount) AS "sevenDaySpeed"
    sum(thirtyDaySpeedCount) AS "thirtyDaySpeed"
    sum(oneDayGradeCount) AS "oneDayGrade"
    sum(twoDayGradeCount) AS "twoDayGrade"
    sum(sevenDayGradeCount) AS "sevenDayGrade"
    sum(thirtyDayGradeCount) AS "thirtyDayGrade"
    sum(oneDayTotalCount) AS "oneDayCount"
    sum(twoDayTotalCount) AS "twoDayCount"
    sum(sevenDayTotalCount) AS "sevenDayCount"
    sum(thirtyDayTotalCount) AS "thirtyDayCount"
    sum(oneDayTotalTime) AS "oneDayTime"
    sum(twoDayTotalTime) AS "twoDayTime"
    sum(sevenDayTotalTime) AS "sevenDayTime"
    sum(thirtyDayTotalTime) AS "thirtyDayTime"
    sum(oneDayGradeTime) AS "oneDayGradeTime"
    sum(twoDayGradeTime) AS "twoDayGradeTime"
    sum(sevenDayGradeTime) AS "sevenDayGradeTime"
    sum(thirtyDayGradeTime) AS "thirtyDayGradeTime"
    sum(oneDaySpeedTime) AS "oneDaySpeedTime"
    sum(twoDaySpeedTime) AS "twoDaySpeedTime"
    sum(sevenDaySpeedTime) AS "sevenDaySpeedTime"
    sum(thirtyDaySpeedTime) AS "thirtyDaySpeedTime"
    sum(oneDayWastedTime) AS "oneDayWastedTime"
    sum(twoDayWastedTime) AS "twoDayWastedTime"
    sum(sevenDayWastedTime) AS "sevenDayWastedTime"
    sum(thirtyDayWastedTime) AS "thirtyDayWastedTime"
    BY appName 
| eval oneDaySpeedPercent=round(100-((oneDaySpeed/oneDayCount)*100),2)
| eval twoDaySpeedPercent=round(100-((twoDaySpeed/twoDayCount)*100),2)
| eval sevenDaySpeedPercent=round(100-((sevenDaySpeed/sevenDayCount)*100),2)
| eval thirtyDaySpeedPercent=round(100-((thirtyDaySpeed/thirtyDayCount)*100),2)
| eval oneDayGradePercent=round(100-((oneDayGrade/oneDayCount)*100),2)
| eval twoDayGradePercent=round(100-((twoDayGrade/twoDayCount)*100),2)
| eval sevenDayGradePercent=round(100-((sevenDayGrade/sevenDayCount)*100),2)
| eval thirtyDayGradePercent=round(100-((thirtyDayGrade/thirtyDayCount)*100),2)
| eval oneDaySpeedTimePercent=round(((oneDaySpeedTime/oneDayTime)*100),2)
| eval twoDaySpeedTimePercent=round(((twoDaySpeedTime/twoDayTime)*100),2)
| eval sevenDaySpeedTimePercent=round(((sevenDaySpeedTime/sevenDayTime)*100),2)
| eval thirtyDaySpeedTimePercent=round(((thirtyDaySpeedTime/thirtyDayTime)*100),2)
| eval oneDayGradeTimePercent=round(((oneDayGradeTime/oneDayTime)*100),2)
| eval twoDayGradeTimePercent=round(((twoDayGradeTime/twoDayTime)*100),2)
| eval sevenDayGradeTimePercent=round(((sevenDayGradeTime/sevenDayTime)*100),2)
| eval thirtyDayGradeTimePercent=round(((thirtyDayGradeTime/thirtyDayTime)*100),2)
| eval oneDayWastedTimePercent=round(((oneDayWastedTime/oneDayTime)*100),2)
| eval twoDayWastedTimePercent=round(((twoDayWastedTime/twoDayTime)*100),2)
| eval sevenDayWastedTimePercent=round(((sevenDayWastedTime/sevenDayTime)*100),2)
| eval thirtyDayWastedTimePercent=round(((thirtyDayWastedTime/thirtyDayTime)*100),2)
| eval oneSevenThirtySpeed=oneDaySpeedPercent."% / ".sevenDaySpeedPercent."% / ".thirtyDaySpeedPercent."%"
| eval oneSevenThirtyGrade=oneDayGradePercent."% / ".sevenDayGradePercent."% / ".thirtyDayGradePercent."%"
| eval oneSevenThirtySpeedTime=oneDaySpeedTimePercent."% / ".sevenDaySpeedTimePercent."% / ".thirtyDaySpeedTimePercent."%"
| eval oneSevenThirtyGradeTime=oneDayGradeTimePercent."% / ".sevenDayGradeTimePercent."% / ".thirtyDayGradeTimePercent."%"
| eval oneSevenThirtyWastedTime=oneDayWastedTimePercent."% / ".sevenDayWastedTimePercent."% / ".thirtyDayWastedTimePercent."%"
| stats 
    values(oneSevenThirtyGrade) as "Reliability"
    values(oneSevenThirtySpeed) as "Performance"
    values(oneDayGradePercent) as yesterdayGrade
    values(oneDayGradeTimePercent) as yesterdayGradeTime
    values(oneDaySpeedPercent) as yesterdaySpeed
    values(oneDaySpeedTimePercent) as yesterdaySpeedTime
    values(oneDayWastedTime) as yesterdayWastedTime
    values(oneDayWastedTimePercent) as yesterdayWastedTimePercent
    values(twoDayGradePercent) as twoDayGradePercent
    values(twoDayGradeTimePercent) as twoDayGradeTimePercent
    values(twoDaySpeedPercent) as twoDaySpeedPercent
    values(twoDaySpeedTimePercent) as twoDaySpeedTimePercent
    values(twoDaysWastedTime) as twoDaysWastedTime
    values(twoDayWastedTimePercent) as twoDayWastedTimePercent
    BY appName
| join type=inner appName [
| inputcsv dailyJAGExecutiveAvailabilitySiteScope.csv
| eval dateEpoch=strptime(date,"%Y/%m/%d")
| eval today=relative_time(now(), "-0d@d")
| eval dataAgeDays=round((today-dateEpoch)/86400,0)
| eval oneDayAvailabilityCount=if((dataAgeDays >= 1), availabilitySuccessCount, NULL())
| eval twoDayAvailabilityCount=if((dataAgeDays <= 1 AND dataAgeDays <= 2), availabilitySuccessCount, NULL())
| eval sevenDayAvailabilityCount=if((dataAgeDays <= 1 AND dataAgeDays <= 7), availabilitySuccessCount, NULL())
| eval thirtyDayAvailabilityCount=if((dataAgeDays <= 1 AND dataAgeDays <= 30 ), availabilitySuccessCount, NULL())
| eval oneDayTotalAvailabilityCount=if((dataAgeDays >= 1), availabilitytotalCount, NULL())
| eval twoDayTotalAvailabilityCount=if((dataAgeDays <= 1 AND dataAgeDays <= 2), availabilitytotalCount, NULL())
| eval sevenDayTotalAvailabilityCount=if((dataAgeDays <= 1 AND dataAgeDays <= 7), availabilitytotalCount, NULL())
| eval thirtyDayTotalAvailabilityCount=if((dataAgeDays <= 1 AND dataAgeDays <= 30 ), availabilitytotalCount, NULL())
| stats 
    sum(oneDaySpeedCount) AS "oneDaySpeed"
    sum(twoDaySpeedCount) AS "twoDaySpeed"
    sum(sevenDaySpeedCount) AS "sevenDaySpeed"
    sum(thirtyDaySpeedCount) AS "thirtyDaySpeed"
    sum(oneDayGradeCount) AS "oneDayGrade"
    sum(twoDaySpeedCount) AS "twoDayGrade"
    sum(sevenDayGradeCount) AS "sevenDayGrade"
    sum(thirtyDayGradeCount) AS "thirtyDayGrade"
    sum(oneDayTotalCount) AS "oneDayCount"
    sum(twoDayTotalCount) AS "twoDayCount"
    sum(sevenDayTotalCount) AS "sevenDayCount"
    sum(thirtyDayTotalCount) AS "thirtyDayCount"
    sum(oneDayAvailabilityCount) AS "oneDayAvailability"
    sum(twoDayAvailabilityCount) AS "twoDayAvailability"
    sum(sevenDayAvailabilityCount) AS "sevenDayAvailability"
    sum(thirtyDayAvailabilityCount) AS "thirtyDayAvailability"
    sum(oneDayTotalAvailabilityCount) AS "oneDayTotalAvailabilityCount"
    sum(twoDayTotalAvailabilityCount) AS "twoDayTotalAvailabilityCount"
    sum(sevenDayTotalAvailabilityCount) AS "sevenDayTotalAvailabilityCount"
    sum(thirtyDayTotalAvailabilityCount) AS "thirtyDayTotalAvailabilityCount"
    BY appName
| eval oneDayAvailabilityPercent=round(((oneDayAvailability)/oneDayTotalAvailabilityCount)*100,2)
| eval twoDayAvailabilityPercent=round(((twoDayAvailability)/twoDayTotalAvailabilityCount)*100,2)
| eval sevenDayAvailabilityPercent=round(((sevenDayAvailability)/sevenDayTotalAvailabilityCount)*100,2)
| eval thirtyDayAvailabilityPercent=round(((thirtyDayAvailability)/thirtyDayTotalAvailabilityCount)*100,2)
| eval yesterdayAvailability=oneDayAvailabilityPercent
| eval oneSevenThirtyAvailability=oneDayAvailabilityPercent."% / ".sevenDayAvailabilityPercent."% / ".thirtyDayAvailabilityPercent."%"
| fields appName oneSevenThirtyAvailability yesterdayAvailability twoDayAvailabilityPercent
| rename oneSevenThirtyAvailability AS "Availability"
]
| table appName yesterday* twoDay* Reliability Performance Availability
| eval overallHealth=round((yesterdayAvailability+yesterdaySpeed+yesterdayGrade)/3,2)
| eval twoDayHealth=round((twoDayAvailabilityPercent+twoDaySpeedPercent+twoDayGradePercent)/3,2)
| eval availabilityTrend=case((yesterdayAvailability < twoDayAvailabilityPercent), "↘", (yesterdayAvailability > twoDayAvailabilityPercent), "↗", (yesterdayAvailability = twoDayAvailabilityPercent),"➡️")
| eval performanceTrend=case((yesterdaySpeed < twoDaySpeedPercent), "↘", (yesterdaySpeed > twoDaySpeedPercent), "↗", (yesterdaySpeed = twoDaySpeedPercent),"➡️")
| eval reliabilityTrend=case((yesterdayGrade < twoDayGradePercent), "↘", (yesterdayGrade > twoDayGradePercent), "↗", (yesterdayGrade= twoDayGradePercent),"➡️")
| eval wastedTimeTrend=case((yesterdayWastedTimePercent < twoDayWastedTimePercent), "↘", (yesterdayWastedTimePercent > twoDayWastedTimePercent), "↗", (yesterdayWastedTimePercent = twoDayWastedTimePercent),"➡️")
| eval overallTrend=case((overallHealth < twoDayHealth), "↘", (overallHealth > twoDayHealth), "↗", (overallHealth = twoDayHealth),"➡")
| sort overallHealth appName 
| eval overallHealth=overallHealth."%"
| eval yesterdayAvailability=yesterdayAvailability."%"
| eval yesterdayGrade=yesterdayGrade."%"
| eval yesterdaySpeed=yesterdaySpeed."%"
| eval yesterdaySpeedTime=round(yesterdaySpeedTime,0)." s"
| eval yesterdayGradeTime=round(yesterdayGradeTime,0)." s"
| eval yesterdayWastedTime=round(yesterdayWastedTime,0)." s"
| fields - two* 
| rename
    appName AS "Application"
    yesterdayWastedTime AS "Wait Time Yesterday"
    yesterdayWastedTimePercent AS "Wait Percent Yesterday"
    wastedTimeTrend AS "Wait Trend"
    yesterdayAvailability AS "Availability Yesterday"
    availabilityTrend AS "Availability Trend"
    yesterdaySpeed AS "Performance Yesterday"
    performanceTrend AS "Performance Trend"
    yesterdaySpeedTime AS "Performance Wait Yesterday"
    yesterdayGrade AS "Reliability Yesterday"
    yesterdayGradeTime AS "Reliability Wait Yesterday"
    reliabilityTrend AS "Reliability Trend"
    overallHealth AS "Overall Health"
    overallTrend AS "Overall Trend"