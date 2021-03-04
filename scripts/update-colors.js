// prevent nvim module to log debug
process.env.NVIM_NODE_LOG_LEVEL = 'error'
process.env.ALLOW_CONSOLE = 'yes'

const fs = require('fs').promises
const path = require('path')
const os = require('os')
const net = require('net')

let theme
if (new Date().getHours() >= 18)
  theme = 'dark'
else theme = 'light'

async function alacritty() {
  const yaml = require('yaml')
  const file = path.join(__dirname, '../alacritty/alacritty.yml')

  const content = await fs.readFile(file, 'utf8')
  const doc = yaml.parseDocument(content)
  const alias = doc.anchors.createAlias(doc.anchors.getNode(theme))

  doc.set('colors', alias) 
  await fs.writeFile(file, doc.toString())
}

async function bat() {
  const file = path.join(__dirname, '../bat/config')
  let config = await fs.readFile(file, 'utf8')

  let batTheme = 'gruvbox'
  if (theme == 'light') batTheme += '-' + theme

  config = config.replace(/(--theme)="[^"]+"/, `$1="${batTheme}"`)
  await fs.writeFile(file, config)
}

async function nvim() {
  const colorFile = path.join(os.homedir(), '.nvim_color')
  const cmd = `set background=${theme}`
  await fs.writeFile(colorFile, cmd)

  // Windows names pipe root
  const ipcDir = '\\\\.\\pipe\\\\'
  const ipcList = (await fs.readdir(ipcDir))
    .filter(name => name.startsWith('nvim'))

  if (ipcDir.length == 0) return

  const nvim = require('neovim')
  for (ipc of ipcList) {
    const socket = net.connect(`${ipcDir}${ipc}`)
    const client = nvim.attach({ 
      reader: socket,
      writer: socket
    })
    await client.command(cmd)
    socket.end()
  }
}

alacritty()
bat()
nvim()
