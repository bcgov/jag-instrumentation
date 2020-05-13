# created by Ranti Familusi ranti.familusi@nttdata.com

Set-ExecutionPolicy Unrestricted -Scope CurrentUser


# ensure a csv folder is created in this location and all csv is copied into the csv folder
# get path of current location - this is where the powershell script is located 
$ourpath = Get-Location
$folderPath = $ourpath.Path+"\csv\"
$folderPath
$files = Get-ChildItem -Path $folderPath
foreach  ($file in $files.Name)
{
   #console out file name
   $file 

   #generate name to use for config file
   $conf_file_name = $file  -replace ".csv$" , ".conf"

   $ourpath.Path
   $csv_path = $ourpath.Path+"\csv\"+$file
   $csv_path
   #extract csv
   $performance_objects = Import-Csv $csv_path
   #generate string value for config
   foreach ($item in $performance_objects) {
      # get sql server instance to monitor
      $instance = "*";
      if ($item.Instance -eq 'sqlservr')  {
         $instance = Read-Host -Prompt 'Input your SQL Server Instance  name'
      }
      else {
         $instance = $item.Instance
      }
      $conf += "[perfmon://" + $name + ([Environment]::NewLine) + "object = " + $item.Object + ([Environment]::NewLine) + "counters = " + $item.Counters + ([Environment]::NewLine) + "instances = " + $instance + ([Environment]::NewLine) + "disabled = 0" + ([Environment]::NewLine) + "interval = 60" + ([Environment]::NewLine) + ([Environment]::NewLine)
   }
   #create config file
   $filePath = $ourpath.Path + "\"+ $conf_file_name
   New-Item -Path $filePath -ItemType File -Force
   #write out config
   Set-Content -Path $filePath -Value $conf
   $conf = ""
}


