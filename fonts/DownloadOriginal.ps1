. ./DownloadLib.ps1

$LatestRelease = Invoke-WebRequest -Uri "https://github.com/JetBrains/JetBrainsMono/releases/latest"
$ReleaseLinks = $LatestRelease.Links | Where-Object -Property Href -Like -Value "*/JetBrainsMono-*.zip"
$OutDir = "$PSScriptRoot/original"

mkdir -Force $OutDir

$Link = "https://github.com/$($ReleaseLinks[0].Href)"
$OutDest = "$OutDir/$(Split-Path -Path $Link -Leaf)"
Download -Uri $Link -Dest $OutDest

7z x "-o$OutDir" $OutDest
