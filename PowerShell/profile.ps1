Invoke-Expression (&starship init powershell)

$targetColor =  if ((Get-Date).Hour -lt 18) { "light" } else { "dark" }

$envColor = 'AlacrittyColor'
$currentColor = [Environment]::GetEnvironmentVariable($envColor, 'User')

if ($currentColor -ne $targetColor) {
  $configFile = "$env:APPDATA\alacritty\alacritty.yml"
  yq e ".colors alias = `\`"$targetColor`\`"" -i $configFile
  [Environment]::SetEnvironmentVariable($envColor, $targetColor, 'User')
}

$env:BAT_THEME = 'gruvbox'
if ($targetColor -eq 'light') {
  $env:BAT_THEME += '-light'
}

