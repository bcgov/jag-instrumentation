## Project Structure

    .        
    ecm                 # ecm splunk configs, dashboard queries and architecture.
    ├── configs         # splunk configs
    ├── script          # scripts to generate conf file for perfmon (python and powershell)
    ├── dashboards      # dahsboard queries
    ├── splunk-lab      # contains azure template for deploying splunk in acs
    └── queries         # splunk queries 

## Run Powershel script (Generate config file using all performance objects existing on the windows server)
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

## Run Powershel script (Generate config file using all performance objects (and counters) pre selected in csv format)
File can be found in /script/perfmon_extract_parse_csv.ps1

Sample for for the csv file can be found in */script/csv* folder. Generate csv file matching the format and place in the */script/csv/* folder

Open Powershell

Run
    ```
    Set-ExecutionPolicy Unrestricted
    ```

Navigate to powershell script file

Run
```
.\perfmon_extract_parse_csv.ps1
```

ps.input.conf file will be generated and should renamed as input.conf before use.
