$ErrorActionPreference = "Stop"

$javaCommand = Get-Command java

if ($javaCommand.version.major -ne 8) {
  Write-Host Only support JDK 8
  exit
}

$oracleVersionKey = '1.8'
$oracleJavaSoftKey = 'Java Development Kit'
$javaHome = (Get-Item $javaCommand.source).Directory.Parent.FullName

if (-Not (Test-Path -Path "$javaHome\jre" -PathType Container)) {
  Write-Host Only Support JDK
  exit
}

try {
  $regPath = 'HKLM:\\SOFTWARE\JavaSoft\'
  if (-Not (Test-Path $regPath)) {
    New-Item $regPath
  }
  Set-Location $regPath

  if (-Not (Test-Path .\$oracleJavaSoftKey)) {
    New-Item .\$oracleJavaSoftKey
  }
  Set-Location .\$oracleJavaSoftKey

  Set-ItemProperty -Path .\ -Name 'CurrentVersion' -Value $oracleVersionKey

  if (-Not (Test-Path $oracleVersionKey)) {
    New-Item -Path .\ -Name $oracleVersionKey
  }
  Set-ItemProperty -Path .\$oracleVersionKey -Name 'JavaHome' -Value $javaHome
} catch {
  Write-Host Error Ocurred
  Write-Host $_
  Write-Host $_.ScriptStackTrace
}

Set-Location $PSScriptRoot
