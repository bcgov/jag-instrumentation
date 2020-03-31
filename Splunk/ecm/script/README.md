## Project Structure

    .        
    ecm                 # ecm splunk configs, dashboard queries and architecture.
    ├── configs         # splunk configs
    ├── script          # scripts to generate conf file for perfmon (python and powershell)
    ├── dashboards      # dahsboard queries
    ├── splunk-lab      # contains azure template for deploying splunk in acs
    └── queries         # splunk queries 

## Run Powershel script
File can be found in /script/perfmon_extract.ps1

Open Powershell

Run
    ```
    Set-ExecutionPolicy Unrestricted
    ```

Navigate to powershell script file

Run
```
.\pefrmon_extract.ps1
```

ps.input.conf file will be generated and should renamed as input.conf before use.
