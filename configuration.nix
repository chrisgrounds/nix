{ pkgs, inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    inputs.nixvim.nixosModules.nixvim
    inputs.niri.nixosModules.niri

    ./modules/home-manager/home.nix

    ./modules/nixos/system.nix
    ./modules/nixos/users.nix
    ./modules/nixos/niri.nix
    ./modules/nixos/zsh.nix
    ./modules/nixos/nvim.nix
    ./modules/nixos/steam.nix
  ];

  nix = {
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  # My modules
  steam.enable = true;

  users.defaultUserShell = pkgs.zsh;

  programs.nix-ld.enable = true;
  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    git
    wezterm
    rustup
    htop
    nixfmt-rfc-style
    gcc
    gnumake
    spotify
    discord
    fzf
    ripgrep
    kitty
    catppuccin-sddm
    rofi
    alacritty
    swaylock
    swaybg
  ];

  system.stateVersion = "25.05";
}
