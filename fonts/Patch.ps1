$Dir = "$PSScriptRoot/"
$OutDir = "$Dir/patched"
$OrigDir = "$Dir/original"
$FontFiles = Get-ChildItem "$OrigDir/fonts/ttf/*" 

mkdir -Force $OutDir

foreach ($File in $FontFiles) {
  fontforge -script "$Dir/patcher/font-patcher" -w -c --careful -out $OutDir $File.FullName 
}

Copy-Item -Path $OrigDir/AUTHORS.txt -Destination $OutDir/AUTHORS.txt
Copy-Item -Path $OrigDir/OFL.txt -Destination $OutDir/OFL.txt
