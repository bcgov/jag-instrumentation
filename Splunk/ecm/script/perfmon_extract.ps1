Set-ExecutionPolicy Unrestricted


$all_objects = typeperf -q
$array_item_duplicates = [System.Collections.ArrayList]@()
$ourpath = Get-Location
foreach ($item in $all_objects) {
   # $item | Get-Member
    if (!$item.Contains("Exiting") -and !$item.Contains("completed"))
    {
       $array_item = $item.Split("\")
       if ($array_item)
      { $id = $array_item_duplicates.Add($array_item[1].Replace("(*)",""))}
    }
}
$conf = ""
$array_objects = $array_item_duplicates | sort | Get-Unique

$array_objects

foreach ($item in $array_objects) {
$conf  += "[perfmon://"+$item+"]" +([Environment]::NewLine) + "object = "+$item +([Environment]::NewLine) + "counters = *" + ([Environment]::NewLine) + "instances = *" +([Environment]::NewLine) +"disabled = 0"  + ([Environment]::NewLine) +"interval = 60"  +  ([Environment]::NewLine) +  ([Environment]::NewLine)
}
$filePath = $ourpath.Path + "\ps.input.conf"
New-Item -Path $filePath -ItemType File -Force

Set-Content -Path $filePath -Value $conf


