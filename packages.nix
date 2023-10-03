{ config, pkgs, ... }:


{
  nixpkgs.config.allowUnfree = true;
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  

  # And ensure gnome-settings-daemon udev rules are enabled 
  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

  #minimal gnome
  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
    #gnome-text-editor
    gnome-connections
    simple-scan
    gnome-usage
    #gnome-console
  ]) ++ 
  (with pkgs.gnome; [
    #gnome-calculator
    #gnome-system-monitor
    #file-roller
    #gnome-disk-utility
    #baobab
    gnome-logs
    seahorse
    eog
    gnome-maps
    gnome-font-viewer
    yelp
    gnome-calendar
    gnome-contacts
    cheese # webcam tool
    gnome-music
    gnome-software
    epiphany # web browser
    geary # email reader
    evince # document viewer
    gnome-characters
    gnome-weather 
    gnome-clocks
    totem # video player
    tali # poker game
    iagno # go game
    hitori # sudoku game
    atomix # puzzle game
  ]);


  services.xserver.excludePackages = (with pkgs; [ 
    xterm 
  ]);

  environment.systemPackages = with pkgs; [

    #communication
    discord

    #browser
    brave

    #mouse
    solaar

    #controllers
    xboxdrv
    
    #office 
    #libreoffice-fresh
    
    #gnome shit
    gnomeExtensions.appindicator
    gnomeExtensions.dash-to-dock
    gnomeExtensions.blur-my-shell
    gnomeExtensions.supergfxctl-gex
    gnomeExtensions.compiz-alike-magic-lamp-effect
    gnome.gnome-tweaks
    colloid-icon-theme
    whitesur-icon-theme
    whitesur-gtk-theme
   
    # libraries
    ntfs3g
    linuxHeaders
    linux-firmware
    fakeroot
    alsa-utils
    alsa-firmware
    gjs
   
    #utilities
    streamlink
    wget
    unzip
    time
    socat
    rsync
    ripgrep
    fzf
    neofetch
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

    #flatpak
    flatpak
    flatpak-builder

    # asus system 
    asusctl
    supergfxctl
    switcheroo-control
    
    #virtual machines
    virt-manager
    spice spice-gtk
    spice-protocol
    win-virtio
    win-spice
    
  ];



  programs.gamemode.enable = true;
  
  #flatpak shit
  services.flatpak.enable = true;

  system.activationScripts.installFlatpaks = {
  text = ''
      apps="com.valvesoftware.Steam
      net.rpcs3.RPCS3"

      flatpak_command="${pkgs.flatpak}/bin/flatpak"
      gawk_command="${pkgs.gawk}/bin/awk"
      grep_command="${pkgs.gnugrep}/bin/grep"

      # Add or update the Flatpak remote for Flathub
      $flatpak_command remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

      # Get a list of already installed Flatpaks
      installed=$($flatpak_command list --app | $gawk_command '{print $2}')

      # Iterate through the list of installed Flatpaks and remove those not in the list
      for flatpak in $installed; do
        if ! echo "$apps" | $grep_command -q "$flatpak"; then
          $flatpak_command uninstall -y --delete-data "$flatpak" 
        fi
      done

      # Iterate through the list of apps and install if not already installed
      echo "$apps" | while read -r line; do
        if ! echo "$installed" | $grep_command -q "$line"; then
          $flatpak_command install -y flathub "$line"
        fi
      done

      # Update all installed Flatpaks
      $flatpak_command update -y
    '';
  };


  

  #virtmanager
  programs.dconf.enable = true;
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


  #asus system services
  services = {
    asusd = {
      enable = true;
      enableUserService = true;
    };
  };
  services.supergfxd.enable = true;
  systemd.services.supergfxd.path = [ pkgs.pciutils ];

  services.power-profiles-daemon.enable = true;
  services.switcherooControl.enable = true;

  
}
