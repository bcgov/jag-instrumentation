# created by Ranti Familusi ranti.familusi@nttdata.com

Set-ExecutionPolicy Unrestricted -Scope CurrentUser

# get all performance counters on computer / server script is ran on
$all_objects = typeperf -q
$array_item_duplicates = [System.Collections.ArrayList]@()
# get path of current location - this is where the powershell script is located 
$ourpath = Get-Location
#clean up - remove generic text 
foreach ($item in $all_objects) {
   
    if (!$item.Contains("Exiting") -and !$item.Contains("completed"))
    {
       $array_item = $item.Split("\")
       if ($array_item)
      { $id = $array_item_duplicates.Add($array_item[1].Replace("(*)",""))}
    }
}
$conf = ""
#sort and remove duplicates objects caused by multiple counters 
$array_objects = $array_item_duplicates | sort | Get-Unique

$array_objects
  #generate string value for config , using all instances and counters
foreach ($item in $array_objects) {
$conf  += "[perfmon://"+$item+"]" +([Environment]::NewLine) + "object = "+$item +([Environment]::NewLine) + "counters = *" + ([Environment]::NewLine) + "instances = *" +([Environment]::NewLine) +"disabled = 0"  + ([Environment]::NewLine) +"interval = 60"  +  ([Environment]::NewLine) +  ([Environment]::NewLine)
}
$filePath = $ourpath.Path + "\ps.input.conf"
New-Item -Path $filePath -ItemType File -Force

Set-Content -Path $filePath -Value $conf


