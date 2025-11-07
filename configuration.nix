{ config, pkgs, ... }:

let
  home-manager = builtins.fetchTarball
    "https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz";
  nixvim = import (builtins.fetchGit {
    url = "https://github.com/nix-community/nixvim";
    ref = "nixos-25.05";
  });
in {
  imports = [
    ./hardware-configuration.nix
    (import "${home-manager}/nixos")
    nixvim.nixosModules.nixvim
  ];

  nix = { settings.experimental-features = [ "nix-command" "flakes" ]; };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

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

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "gb";
    variant = "";
  };

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
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [ kdePackages.kate ];
  };

  users.defaultUserShell = pkgs.zsh;

  # Program Configuration
  # programs.hyprland.enable = false;

  programs.nix-ld.enable = true;

  programs.ssh.startAgent = true;

  programs.firefox.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    ohMyZsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "robbyrussell";
    };

    shellAliases = { zed = "zeditor"; };
  };

  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;

    opts = {
      number = true;
      shiftwidth = 2;
    };

    autoCmd = [{
      event = [ "VimEnter" ];
      pattern = [ "*" ];
      command = "if &diff | colorscheme blue | endif";
    }];

    colorschemes.catppuccin.enable = true;

    plugins.lsp = {
      enable = true;
      servers = { nixd.enable = true; };
    };

    plugins.conform-nvim = {
      enable = true;
      settings.formatters_by_ft.nix = [ "nixfmt" ];
      settings.format_on_save = {
        # Format on save in all files
        lspFallback = true;
        timeoutMs = 500;
      };
    };

    plugins.treesitter = {
      enable = true;
      grammarPackages = with pkgs.vimPlugins.nvim-treesitter-parsers; [ nix ];
    };
  };

  home-manager.users.chris = { pkgs, ... }: {
    home.stateVersion = "25.05";
    home.packages = [ ];
    home.sessionVariables = { SHELL = "zsh"; };
    programs.zed-editor = {
      enable = true;
      extraPackages = [ pkgs.nixd ];
      # extensions = [ "nix" "toml" "rust" ];
      # userSettings = {
      #   theme = {
      #     mode = "system";
      #     dark = "One Dark";
      #     light = "One Light";
      #   };
      #   hour_format = "hour24";
      #      lsp = {
      #         rust-analyzer = { binary = { path_lookup = true; }; };
      #
      #  nix = { binary = { path_lookup = true; }; };
      #};
      # };
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vulkan-tools
    git
    wezterm
    rustup
    htop
    nixfmt
    gcc
    gnumake
    spotify
    discord
    fzf
    ripgrep
    kitty
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
