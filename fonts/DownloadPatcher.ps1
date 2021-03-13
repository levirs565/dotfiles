. ./DownloadLib.ps1

$Root = "https://github.com/ryanoasis/nerd-fonts/raw/2.1.0"
$DownloadDir = "$PSScriptRoot/patcher"

mkdir -Force $DownloadDir

$Patcher = "font-patcher"
Download -Uri "$Root/$Patcher" -Dest "$DownloadDir/$Patcher"

$GlyphPath = "src/glyphs"
$GlyphsTree = Invoke-WebRequest -Uri "$Root/$GlyphPath"
$GlyphLinks = $GlyphsTree.Links | Where-Object -Property href -Match -Value ".+(\.otf|\.ttf|\.sfd)"
$GlyphDir = "$DownloadDir/$GlyphPath"

mkdir -Force $GlyphDir

foreach ($Link in $GlyphLinks) {
  $DownloadLink = "https://github.com/$($Link.Href)" -Replace "/blob/", "/raw/"
  $DownloadDest = "$GlyphDir/$($Link.Title)"
  Download -Uri $DownloadLink -Dest $DownloadDest
}
