local wezterm = require 'wezterm';

return {
  font = wezterm.font("JetBrainsMono NF"),
  font_size = 11.0,
  color_scheme = "Gruvbox Light",
  default_prog = {"pwsh"},
  default_cwd = os.getenv("HOMEDRIVE") .. os.getenv("HOMEPATH"),
  foreground_text_hsb = {
    hue = 1.0,
    saturation = 1.0,
    brightness = 1.0,
  },
  launch_menu = {
    {
      label = "Neovim",
      args = { "nvim" }
    }
  }
}
