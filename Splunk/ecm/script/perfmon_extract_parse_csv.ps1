Set-ExecutionPolicy Unrestricted -Scope CurrentUser

$ourpath = Get-Location
$folderPath = $ourpath.Path+"\csv\"
$folderPath
$files = Get-ChildItem -Path $folderPath
foreach  ($file in $files.Name)
{
   $conf_file_name = $file  -replace ".csv$" , ".conf"

$ourpath.Path
$csv_path = $ourpath.Path+"\csv\"+$file
$csv_path
$performance_objects = Import-Csv $csv_path
foreach ($item in $performance_objects) {
   $name = $item.Object -replace "�", " "
   
   $conf += "[perfmon://" + $name + ([Environment]::NewLine) + "object = " + $item.Object + ([Environment]::NewLine) + "counters = " + $item.Counters + ([Environment]::NewLine) + "instances = " + $item.Instance + ([Environment]::NewLine) + "disabled = 0" + ([Environment]::NewLine) + "interval = 60" + ([Environment]::NewLine) + ([Environment]::NewLine)
}

$filePath = $ourpath.Path + "\"+ $conf_file_name
New-Item -Path $filePath -ItemType File -Force

Set-Content -Path $filePath -Value $conf
$conf = ""
}


