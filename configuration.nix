{ pkgs, ... }:

let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz";
  nixvim = import (
    builtins.fetchGit {
      url = "https://github.com/nix-community/nixvim";
      ref = "nixos-25.05";
    }
  );
in
{
  imports = [
    ./hardware-configuration.nix
    (import "${home-manager}/nixos")
    nixvim.nixosModules.nixvim
    # Custom modules
    (import ./zsh.nix)
    (import ./nvim.nix)
    (import ./steam.nix)
  ];

  nix = {
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  nixpkgs.config.allowUnfree = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;
  services.xserver.xkb = {
    layout = "gb";
    variant = "";
  }; # Configure keymap in X11

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure console keymap
  console.keyMap = "uk";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

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

  # programs.hyprland.enable = false;
  programs.nix-ld.enable = true;
  programs.ssh.startAgent = true;
  programs.firefox.enable = true;

  home-manager.users.chris =
    { ... }:
    {
      home.stateVersion = "25.05";
      home.packages = [ ];
      home.sessionVariables = {
        SHELL = "zsh";
      };
      imports = [ ./zed.nix ];
    };

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
  ];

  system.stateVersion = "25.05";
}
