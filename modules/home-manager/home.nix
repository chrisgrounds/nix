{ inputs, ... }:
{
  home-manager.users.chris = {
    home.username = "chris";
    home.homeDirectory = "/home/chris";
    home.stateVersion = "25.05";
    home.packages = [ ];
    home.sessionVariables = {
      SHELL = "zsh";
    };
    imports = [
      inputs.zen-browser.homeModules.twilight
      # inputs.niri.homeModules.niri
      inputs.dms.homeModules.dankMaterialShell.default

      ./zed.nix
      ./zen.nix
    ];

    xdg.configFile."niri/config.kdl".source = ./niri/config.kdl;
  };
}
