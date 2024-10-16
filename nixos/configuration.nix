# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  #boot.loader.grub.enable = true;
  #boot.loader.grub.device = "/dev/sda";
  #boot.loader.grub.useOSProber = true;
  
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  programs.fish.enable = true;
 programs.bash = {
  interactiveShellInit = ''
    if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
    then
      shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
      exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
    fi
  '';
};

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  environment.sessionVariables.EDITOR = "nvim";
  # Enable the GNOME Desktop Environment.

  # Configure keymap in X11
  services.xserver = {
    layout = "eu";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jan = {
    isNormalUser = true;
    description = "Jan Lunge";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
      firefox
    #  thunderbird
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  # wget
  chromium
  vscode
  vim
  firefox
  neovim
  fish
  tmux
  herbstluftwm
  xterm
  git
  rofi
  feh
  polybar
  termite
  arandr
  discord
  vulkan-tools # for testing vulkan support for steam
  telegram-desktop
  docker-compose
  # wormhole?
  jq
  nitrogen
  neovim

  # AI Stuff
  # nvidia-smi # for cuda stuff
  cudatoolkit
  #zlib
  #gcc
  #python311
  #curl
  #stdenv.cc.cc.lib
  #stdenv.cc
  #ncurses5
  #binutils
  #gitRepo gnupg autoconf
  #procps gnumake util-linux m4 gperf unzip libGLU libGL
  #glib
  krita
  mpv
  cifs-utils
  vial
  htop
  flameshot
  killall
  tree
  lf
  pistol
  starship
  pavucontrol
  spotify
  jdk21
  picom
  
];

services.udev.packages = with pkgs; [
  vial
];

#services.dunst.enable = true;

#xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
xdg.portal.config.common.default = "gtk";
services.flatpak.enable = true;
virtualisation.docker.enable = true;
virtualisation.podman.enable = true;
virtualisation.docker.enableNvidia = true;
fonts.fontDir.enable = true;
fonts.packages = with pkgs; [
  mononoki
(nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "Mononoki" ]; })
];
services.xserver = {
  enable = true;
  serverFlagsSection = 
  ''
  Option "StandbyTime" "30" 
  Option "BlankTime" "30"
  Option "SuspendTime" "40"
  Option "OffTime" "60"
  '';
  windowManager = {
    herbstluftwm.enable = true;
  };
  videoDrivers = ["nvidia"];
  displayManager = {
    session = [
      { manage = "desktop";
        name = "herbstluft";
        start = ''
          ${pkgs.herbstluftwm}/bin/herbstluftwm --locked &
          waitPID=$!
        '';
      }
    ];
    gdm.enable = true;
    defaultSession = "herbstluft";
  };
};

  services.xserver.desktopManager.gnome.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  hardware.opengl.enable = true;
 systemd.services.nvidia-control-devices = {
    wantedBy = [ "multi-user.target" ];
    serviceConfig.ExecStart = "${pkgs.linuxPackages.nvidia_x11.bin}/bin/nvidia-smi";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
  enable = true;
  ports = [ 22 ];
  settings = {
    PasswordAuthentication = true;
    AllowUsers = null; # Allows all users by default. Can be [ "user1" "user2" ]
    UseDns = true;
    X11Forwarding = false;
    PermitRootLogin = "prohibit-password"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
  };
};

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
  system.stateVersion = "23.11"; # Did you read the comment?

  nix.settings.experimental-features = [ "nix-command" "flakes" ];




}
