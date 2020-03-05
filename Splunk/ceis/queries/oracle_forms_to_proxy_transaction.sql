sourcetype=access_combined (index="prod_web" AND source="/app/apache/httpd_rp/logs/access_log" AND host IN (seethe* simmer* stew*)) OR (index="prod_oracleforms" AND host IN (bert* stubble* orkney* williams*)) "ceis_prod"
| `massageCombinedAccess`
| lookup ceisHostLookup.csv ip AS addressA output hostname AS addressAHostname
| transaction jsessionid maxspan=60s maxpause=1s
| eventstats 
  values(host) as hosts
  earliest(_time) as transactionStartTime
  latest(_time) as transactionEndTime
  dc(_raw) as linesInTransaction
  by jsessionid
| eval uniqueTransaction=jsessionid.":".transactionStartTime
| eval transactionDuration=transactionEndTime-transactionStartTime
| timechart 
  max(duration) as maxDuration
  avg(duration) as avgDuration
| rename 
  maxDuration as "Max Tx Duration"
  avgDuration as "Avg Tx Duration"