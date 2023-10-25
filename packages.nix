{ config, pkgs, ... }:


{
  nixpkgs.config.allowUnfree = true;
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  
  
  /*
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
    gnome-disk-utility
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
  
  */

  services.xserver.excludePackages = (with pkgs; [ 
    xterm 
  ]);

  environment.systemPackages = with pkgs; [


    #gnome exclusive
    #switcheroo-control #dbus for dual gpu
    #gnomeExtensions.appindicator
    #gnomeExtensions.dash-to-dock
    #gnomeExtensions.blur-my-shell
    #gnomeExtensions.supergfxctl-gex
    #gnomeExtensions.compiz-alike-magic-lamp-effect



    #hyprland exclusive
    rofi-wayland
    swaylock
    swww
    eww-wayland
    waybar
    kitty
    grim 
    slurp
    pywal
    starship
    wlogout
    feh
    gnome.file-roller
    gnome.gnome-system-monitor
    gnome.baobab
    gnome.gnome-calculator
    gnome.nautilus
    gnome.gnome-tweaks
    lxqt.lxqt-policykit
    

    #ide 
    vscodium
    direnv
    git

    
    #rustc
    #cargo 
    
    #communication
    discord

    #browser
    brave

    #xbox controllers
    xboxdrv
      
  
    #themes icons gtk
    colloid-icon-theme
    whitesur-icon-theme
    whitesur-gtk-theme
    
   
    #libraries
    ntfs3g
    linuxHeaders
    linux-firmware
    fakeroot
    alsa-utils
    alsa-firmware
    gjs
   
    #utilities
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
    
    #virtual machines
    virt-manager
    spice spice-gtk
    spice-protocol
    win-virtio
    win-spice
    
  ];

  fonts.packages = with pkgs; [
    font-awesome
    iosevka
    noto-fonts-cjk-sans
    jetbrains-mono
    nerdfonts
    cascadia-code
  ];


  programs.gamemode.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
  
  
  #flatpak shit
  services.flatpak.enable = true;

  system.activationScripts.installFlatpaks = {
  text = ''
      apps="net.rpcs3.RPCS3
      com.github.tchx84.Flatseal"

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


  #gnome exclusive services
  #services.switcherooControl.enable = true;

  
}
