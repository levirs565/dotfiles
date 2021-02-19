const yaml = require('yaml')
const fs = require('fs')
const path = require('path')

let theme
if (new Date().getHours() >= 18)
  theme = 'dark'
else theme = 'light'

const alacrittyConfig = path.join(__dirname, '../alacritty/alacritty.yml')
const doc = yaml.parseDocument(fs.readFileSync(alacrittyConfig, 'utf8'))
const alias = doc.anchors.createAlias(doc.anchors.getNode(theme))

doc.set('colors', alias)
fs.writeFileSync(alacrittyConfig, doc.toString())

const batFile = path.join(__dirname, '../bat/config')
let batConfig = fs.readFileSync(batFile, 'utf8')
let batTheme = 'gruvbox'
if (theme == 'light') batTheme += '-' + theme
batConfig = batConfig.replace(/(--theme)="[^"]+"/, `$1="${batTheme}"`)
fs.writeFileSync(batFile, batConfig)
