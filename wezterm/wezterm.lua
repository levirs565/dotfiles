local wezterm = require 'wezterm';

local file = io.open(wezterm.home_dir .. "/.wezterm_color", "r")
local color = file:read("*l")
file:close()

local msys2bash = { "C:\\msys64\\usr\\bin\\bash", "--login" }

return {
  font = wezterm.font("JetBrainsMono NF"),
  font_size = 11.0,
  color_scheme = color,
  default_prog = {"pwsh"},
  default_cwd = wezterm.home_dir,
  foreground_text_hsb = {
    hue = 1.0,
    saturation = 1.0,
    brightness = 1.0,
  },
  launch_menu = {
    {
      label = "Neovim",
      args = { "nvim" }
    },
    {
      label = "MSYS2",
      args = msys2bash,
      set_environment_variables = {
        MSYSTEM = "MSYS"
      }
    },
    {
      label = "MSYS2 MINGW64",
      args = msys2bash,
      set_environment_variables = {
        MSYSTEM = "MINGW64"
      }
    }
  },
  keys = {
    {
      -- Map this to Alt-ENTER
      key = "raw:13",
      mods = "CTRL",
      action = wezterm.action{SendString="\x1b\r"}
    }
  },
  tab_bar_at_bottom = true,
  force_reverse_video_cursor = true
}
