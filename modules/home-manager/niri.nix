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

        # Workspaces – classic Mod+1..9
        "Mod+1".action.focus-workspace = 1;
        "Mod+2".action.focus-workspace = 2;
        "Mod+3".action.focus-workspace = 3;
        "Mod+4".action.focus-workspace = 4;
        "Mod+5".action.focus-workspace = 5;
        "Mod+6".action.focus-workspace = 6;
        "Mod+7".action.focus-workspace = 7;
        "Mod+8".action.focus-workspace = 8;
        "Mod+9".action.focus-workspace = 9;

        "Mod+Shift+1".action.move-column-to-workspace = 1;
        "Mod+Shift+2".action.move-column-to-workspace = 2;
        "Mod+Shift+3".action.move-column-to-workspace = 3;
        "Mod+Shift+4".action.move-column-to-workspace = 4;
        "Mod+Shift+5".action.move-column-to-workspace = 5;
        "Mod+Shift+6".action.move-column-to-workspace = 6;
        "Mod+Shift+7".action.move-column-to-workspace = 7;
        "Mod+Shift+8".action.move-column-to-workspace = 8;
        "Mod+Shift+9".action.move-column-to-workspace = 9;

        # screenshot
        "Mod+Shift+S".action = config.lib.niri.actions.spawn [
          "sh"
          "-c"
          ''
            dir="$HOME/Pictures/Screenshots"
            mkdir -p "$dir"
            file="$dir/screenshot-$(date +%Y%m%d-%H%M%S).png"

            # Take region screenshot, save to file AND copy to clipboard
            grim -g "$(slurp)" - | tee "$file" | wl-copy

            # Optional: tiny DMS notification if you want
            # dms notify "Screenshot saved to $file and copied to clipboard"
          ''
        ];
      };
    };
  };
}
