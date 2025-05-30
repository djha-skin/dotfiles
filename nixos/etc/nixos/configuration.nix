# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs ? (fetchTarball "https://github.com/NixOS/nixpkgs/archive/7819a0d29d1dd2bc331bec4b327f0776359b1fa6.tar.gz") {}, ...}:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./suspend-and-hibernate.nix
      ./user-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-44166ac3-393a-4b41-8fde-e7b918d84176".device = "/dev/disk/by-uuid/44166ac3-393a-4b41-8fde-e7b918d84176";
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";


  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Denver";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
  fonts = {
      fonts = with pkgs; [
          noto-fonts
              noto-fonts-emoji
              font-awesome
      ];
      fontconfig.defaultFonts = {
          serif = [ "Noto Serif" ];
          sansSerif = [ "Noto Sans" ];
          emoji = [ "Noto Color Emoji" ];
      };
      enableDefaultFonts = true;
  };
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = false;
    #alsa.pulseaudio.support32Bit = false;
    #alsa.pulseaudio.package = pkgs.pipewire-pulseaudio;
    #alsa.pulseaudio.enable = false;
    pulse.enable = true;
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = true;
      AllowUsers = ["skin"]; # Allows all users by default. Can be [ "user1" "user2" ]
      UseDns = true;
      X11Forwarding = false;
      PermitRootLogin = "no"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  virtualisation.docker.enable = true;
  users.mutableUsers = false;
  security.sudo.wheelNeedsPassword = false;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    glib
    flock
  ];
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    pkgs.alsa-lib
    pkgs.darwin.Libm
    pkgs.darwin.libpthread
    pkgs.glib
    pkgs.glibmm
    pkgs.gnustep-libobjc
    pkgs.libGL
    pkgs.libGLU
    pkgs.libpng
    pkgs.libvorbis
    pkgs.libz
    pkgs.openssl
    pkgs.xorg.libX11
    pkgs.xorg.libpthreadstubs
    xorg.libxcb
  ];
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs; [
    ];
    extraSessionCommands = ''
      export SDL_VIDEODRIVER=wayland
      export QT_QPA_PLATFORM=wayland
      export _JAVA_AWT_WM_NONPARENTING=1
      export MOZ_ENABLE_WAYLAND=1
    '';
  };
  security.polkit.enable = true;
  security.rtkit.enable = true;
  services.printing.enable = true;


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  programs.ssh.startAgent = true;

  # A good default browser.
  programs.firefox.enable = true;

  services.displayManager.sddm.wayland.enable = true;
  services.displayManager.sddm.enable = true;
  #services.xserver.displayManager.sddm.wayland = true;

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
  system.stateVersion = "24.11"; # Did you read the comment?

}
