Set-ExecutionPolicy Unrestricted


$csv_path = $ourpath.Path+"\csv\windows_performance_counters.csv"
$csv_path
$performance_objects = Import-Csv $csv_path
$performance_objects
foreach ($item in $performance_objects) {
   $conf += "[perfmon://" + $item.Object + "]" + ([Environment]::NewLine) + "object = " + $item.Object + ([Environment]::NewLine) + "counters = " + $item.Counters + ([Environment]::NewLine) + "instances = " + $item.Instance + ([Environment]::NewLine) + "disabled = 0" + ([Environment]::NewLine) + "interval = 60" + ([Environment]::NewLine) + ([Environment]::NewLine)
}

$filePath = $ourpath.Path + "\ps.input.conf"
New-Item -Path $filePath -ItemType File -Force

Set-Content -Path $filePath -Value $conf


