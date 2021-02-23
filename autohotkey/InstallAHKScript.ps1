$StartupDir = [Environment]::GetFolderPath("startup")
$LnkPath = "$StartupDir\My AHK Script.lnk"
$TargetPath = "$(scoop prefix autohotkey)\autohotkeyu64.exe"
$ScriptFile = "$PSScriptRoot\script.ahk"
$WSShell = New-Object -ComObject WScript.Shell
$Shortcut = $WSShell.CreateShortcut($LnkPath)
$Shortcut.TargetPath = $TargetPath
$Shortcut.Arguments = $ScriptFile
$Shortcut.Save()
