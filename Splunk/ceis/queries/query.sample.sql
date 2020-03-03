index=prod_oracleforms sourcetype=access_combined source="/app/oracle/product/wls12c/user_projects/domains/FormsReports/servers/ohs1/logs/access_log"
| `massageCombinedAccess`
| eval ip=addressA
| lookup ceisHostLookup.csv ip output hostname AS hostA
| eval ip=addressB 
| lookup ceisHostLookup.csv ip output hostname AS hostB
| eval internal=if((isnotnull(hostA) and isnotnull(hostB)),"true","false")
| eval hostA=if(isnull(hostA),addressA,hostA)
| eval hostB=if(isnull(hostB),addressB,hostB)
| table hostA hostB internal