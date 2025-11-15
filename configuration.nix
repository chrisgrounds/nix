{ pkgs, inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    inputs.nixvim.nixosModules.nixvim

    ./modules/home-manager/home.nix

    ./modules/nixos/system.nix
    ./modules/nixos/zsh.nix
    ./modules/nixos/nvim.nix
    ./modules/nixos/steam.nix
    ./modules/nixos/niri.nix
  ];

  # My modules
  steam.enable = true;

  nix = {
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;
  services.xserver.xkb = {
    layout = "gb";
    variant = "";
  }; # Configure keymap in X11

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm = {
    enable = true;
    # package = pkgs.kdePackages.sddm;
    wayland = {
      enable = true;
    };
    theme = "catppuccin-macchiato";
  };
  services.desktopManager.plasma6.enable = true;

  users.users.chris = {
    isNormalUser = true;
    description = "chris";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [ kdePackages.kate ];
  };

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
  ];

  system.stateVersion = "25.05";
}
