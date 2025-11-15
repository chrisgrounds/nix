{ inputs, ... }:
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  nixpkgs.config.allowUnfree = true;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
  system.autoUpgrade = {
    enable = true;
    flake = inputs.self.outPath;
    dates = "weekly";
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  hardware.cpu.amd.updateMicrocode = true;

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

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver = {
    enable = true;
    xkb = {
      layout = "gb";
      variant = "";
    }; # Configure keymap in X11
  };

  # Enable the KDE Plasma Desktop Environment.
  # services.displayManager.sddm = {
  #   enable = true;
  #   # package = pkgs.kdePackages.sddm;
  #   wayland = {
  #     enable = true;
  #   };
  #   theme = "catppuccin-macchiato";
  # };
  services.displayManager.gdm = {
    enable = true;
    wayland = true;
  };
  services.desktopManager.plasma6.enable = true;
}
