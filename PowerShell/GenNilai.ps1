$ListNilai = @()
while ($true) {
  $Nilai = Read-Host
  $Valid = -not [String]::IsNullOrEmpty($Nilai)
  if ($Valid) {
    $ListNilai += [int] $Nilai
  } else {
    break
  }
}

$ListPembeda = @(-2,0,2)

foreach ($Pembeda in $ListPembeda) {
  Write-Host "Pembeda = $Pembeda"
  foreach ($Nilai in $ListNilai) {
    Write-Host ($Nilai + $Pembeda)
  }
  Write-Host ""
}
