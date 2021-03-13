function Download($Uri, $Dest) {
  echo "Download from $Uri to $Dest"
  Invoke-WebRequest -Uri $Uri -OutFile $Dest
}
