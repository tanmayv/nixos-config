{ pkgs, inputs, ... }:


{
  nixpkgs.config.allowUnfree = true;


  # List packages installed in system profile. To search, run:
  # $ nix search wget



  # And ensure gnome-settings-daemon udev rules are enabled 
  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

  #minimal gnome
  environment.gnome.excludePackages = (with pkgs; [
    gnome-console
    #gnome-text-editor
    #snapshot
    #loupe
    gnome-photos
    gnome-tour
    gnome-connections
    simple-scan
    gnome-usage
  ]) ++
  (with pkgs; [
    #gnome-calculator
    gnome-system-monitor
    #file-roller
    #baobab
    cheese
    #gnome-disk-utility
    gnome.gnome-logs
    seahorse
    eog
    gnome.gnome-maps
    gnome-font-viewer
    yelp
    gnome-calendar
    gnome.gnome-contacts
    gnome.gnome-music
    gnome.gnome-software
    epiphany # web browser
    geary # email reader
    evince # document viewer
    gnome.gnome-characters
    gnome.gnome-weather
    gnome.gnome-clocks
    totem # video player
    gnome.tali # poker game
    gnome.iagno # go game
    gnome.hitori # sudoku game
    gnome.atomix # puzzle game
  ]);



  services.xserver.excludePackages = (with pkgs; [
    xterm
  ]);

  environment.systemPackages = with pkgs; [


    switcheroo-control #dbus for dual gpu

    #gmome
    gnomeExtensions.appindicator
    gnomeExtensions.supergfxctl-gex
    gnomeExtensions.screen-rotate # 2 in 1 extension
    gnomeExtensions.rounded-window-corners # waiting for update >:(
    gnomeExtensions.auto-move-windows
    gnomeExtensions.vitals
    gnome-tweaks

    #terminal 
    blackbox-terminal

    #video player
    celluloid

    #zsh shit
    starship

    #recording 
    obs-studio

    #browser
    firefox

    #xbox controllers
    xboxdrv

    #discord
    vesktop


    #libraries
    ntfs3g
    linuxHeaders
    linux-firmware
    fakeroot
    alsa-utils
    alsa-firmware
    gjs

    #utilities
    pywal
    killall
    pamixer
    brightnessctl
    upower
    streamlink
    wget
    unzip
    time
    socat
    rsync
    ripgrep
    fzf
    fastfetch
    mpc-cli
    mlocate
    inotify-tools
    groff
    ffmpegthumbnailer
    jellyfin-ffmpeg
    fd
    dialog
    bat
    which
    poppler_utils
    p7zip
    atool
    unrar
    odt2txt
    xlsx2csv
    jq
    mediainfo
    imagemagick
    libnotify
    mangohud



    #virtual machines
    /*
      virt-manager
      spice spice-gtk
      spice-protocol
      win-virtio
      win-spice
    */


    appimage-run #runs appimages 
    steam-run #runs linux binaries


  ];


  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    };
  };


  fonts.packages = with pkgs; [
    font-awesome
    iosevka
    noto-fonts-cjk-sans
    jetbrains-mono
    nerdfonts
    cascadia-code
  ];





  #virtmanager

  /*
    virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        ovmf.enable = true;
        ovmf.packages = [ pkgs.OVMFFull.fd ];
      };
    };
    spiceUSBRedirection.enable = true;
    };
    services.spice-vdagentd.enable = true;
  */



  #podman
  virtualisation = {
    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  #asus system services
  services = {
    asusd = {
      enable = true;
      enableUserService = true;
    };
    supergfxd = {
      enable = true;
      settings = {
        vfio_enable = true;
        hotplug_type = "Asus";
      };
    };
  };

  systemd.services.supergfxd.path = [ pkgs.pciutils pkgs.lsof ];



  #gnome exclusive services
  services.switcherooControl.enable = true;






}
