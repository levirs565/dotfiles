$ErrorActionPreference = 'Stop'
$dirList = Import-Csv LinkList.csv

foreach ($dir in $dirList) {
  $sourceName = $dir.Source
  $sourceDir = Join-Path $PSScriptRoot $sourceName

  $destParent = $dir.DirDestination
  $destDir = Invoke-Expression "Write-Output $destParent"

  if ($dir.LinkChild -ne 'yes') {
    $linkList = @{
      $sourceDir = Join-Path $destDir $sourceName
    }
  } else {
    $linkList = @{}
    Get-ChildItem $sourceDir | ForEach-Object {
      $linkList += @{
        $_.FullName = Join-Path $destDir $_.Name
      }
    }
  }

  foreach ($linkSrc in $linkList.Keys) {
    $linkDest = $linkList[$linkSrc]
    if (Test-Path $linkDest) {
      $destItem = Get-Item $linkDest
      if (($destItem.Target) -eq $linkSrc) {
        Write-Host "Link $linkDest is correct"
        continue
      } else {
        Write-Error "Link $linkDest is incorrect"
        exit
      }
    }
    
    Write-Host Linking $linkDest to $linkSrc
    New-Item -Type SymbolicLink -Path $linkDest -Target $linkSrc
  }
}
