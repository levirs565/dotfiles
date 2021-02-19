// prevent nvim module to log debug
process.env.NVIM_NODE_LOG_LEVEL = 'error'
process.env.ALLOW_CONSOLE = 'yes'

const yaml = require('yaml')
const fs = require('fs')
const path = require('path')
const os = require('os')
const nvim = require('neovim')
const net = require('net')

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

const nvimColorFile = path.join(os.homedir(), '.nvim_color')
const nvimCmd = `set background=${theme}`
fs.writeFileSync(nvimColorFile, nvimCmd)

// Windows names pipe root
const ipcDir = '\\\\.\\pipe\\\\'
const nvimIpcs = fs.readdirSync(ipcDir).filter(name => name.startsWith('nvim'))
for (ipc of nvimIpcs) {
  const socket = net.connect(`${ipcDir}${ipc}`)
  const client = nvim.attach({ 
    reader: socket,
    writer: socket
  })
  client.command(nvimCmd).then(() => {
    socket.end()
  })
}
