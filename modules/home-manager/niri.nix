{ lib, pkgs, ... }:
{
  programs.niri = {
    settings = {
      input = lib.mkDefault {
        mod-key = "Super";
        mod-key-nested = "Alt";
      };
      binds = lib.mkDefault {
        # Application launchers
        "Mod+T".action.spawn = lib.getExe pkgs.wezterm;
        "Mod+D".action.spawn = [
          "rofi"
          "-show"
          "drun"
        ];
      };
    };
  };
}
