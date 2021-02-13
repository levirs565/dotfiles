$linkList = Import-Csv LinkList.csv

foreach ($link in $linkList) {
  $sourceName = $link.Source
  $sourcePath = Join-Path $PSScriptRoot $sourceName

  $destDir = $link.DirDestination
  $destDir = Invoke-Expression "Write-Output $destDir"
  $destPath = Join-Path $destDir $sourceName
  Write-Host Link $destPath to $sourcePath
  New-Item -Type Junction -Path $destPath -Target $sourcePath
}
