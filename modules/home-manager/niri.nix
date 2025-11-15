{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.niri = {
    settings = {
      input = lib.mkDefault {
        mod-key = "Super";
        mod-key-nested = "Alt";
      };
      binds = {
        # Application launchers
        "Mod+T".action.spawn = lib.getExe pkgs.wezterm;
        "Mod+D".action.spawn = [
          "rofi"
          "-show"
          "drun"
        ];

        # focus movement
        "Mod+LEFT".action = config.lib.niri.actions.focus-column-left;
        "Mod+RIGHT".action = config.lib.niri.actions.focus-column-right;
        "Mod+DOWN".action = config.lib.niri.actions.focus-window-down;
        "Mod+UP".action = config.lib.niri.actions.focus-window-up;
      };
    };
  };
}
