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
      inputs.niri.homeModules.niri
      inputs.zen-browser.homeModules.twilight
      inputs.dms.homeModules.dankMaterialShell.default
      inputs.dms.homeModules.dankMaterialShell.niri

      ./zed.nix
      ./zen.nix
      ./dank-material-shell.nix
      # ./niri.nix
    ];

    # Symlink niri/config.kdl
    # xdg.configFile."niri/config.kdl".source = ../../niri/config.kdl;
  };
}
