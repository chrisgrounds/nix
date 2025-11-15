{ ... }:
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
      ./zed.nix
      # ./niri.nix
      #  ./hyprland.nix
    ];
  };
}
