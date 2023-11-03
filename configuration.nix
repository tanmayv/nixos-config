{ config, pkgs, ... }:

{
  system.stateVersion = "23.05";
  boot.kernelPackages = pkgs.linuxPackages_latest;
  
  nix.optimise.automatic = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.shells = with pkgs; [ zsh bash dash ];
  environment.binsh = "${pkgs.dash}/bin/dash";
  programs.zsh.enable = true;
  programs.zsh.enableCompletion = true;
  programs.zsh.ohMyZsh.enable = true;
  #programs.zsh.ohMyZsh.theme = "trapd00r";
  
  system.activationScripts.linkBash = {
    text = ''
      ln -sf ${pkgs.bash}/bin/bash /bin/bash
    '';
  };

  environment.sessionVariables = rec {
    
    #NIXOS_OZONE_WL = "1";
    XDG_CACHE_HOME  = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME   = "$HOME/.local/share";
    XDG_STATE_HOME  = "$HOME/.local/state";

    # Not officially in the specification
    XDG_BIN_HOME = "$HOME/.local/bin";
    PATH = [ 
      "${XDG_BIN_HOME}"
    ];
  };


  #gnome patches
  nixpkgs.overlays = [ 
    
    #gnome vrr patch *doesn't work on unstable channel*
    
    (self: super: {
      gnome = super.gnome.overrideScope' (pself: psuper: {
        
        mutter = psuper.mutter.overrideAttrs (oldAttrs: {
          patches = (oldAttrs.patches or [ ]) ++ [
            
            #dynamic triple/double buffer
            (super.fetchpatch {
              url = "https://aur.archlinux.org/cgit/aur.git/plain/mr1441.patch?h=mutter-dynamic-buffering&id=d3a8bdd1b7bad6a7f3820f143fb8384dcd1ac497";
              hash = "sha256-VHL+++nkbYOsgrlrj3aJHDcOjs/Wkma0+mJzbLsjmrY=";
            })

            (super.fetchpatch {
              url = "https://gitlab.gnome.org/GNOME/mutter/-/merge_requests/3304.patch";
              hash = "sha256-+7wIrXJs10n6f+BWGJNgWM3IN5xwX2ylINYoqVg8YcU=";
            })

            (super.fetchpatch {
              url = "https://gitlab.gnome.org/GNOME/mutter/-/merge_requests/3342.patch";
              hash = "sha256-dveVWMoZQocikLD3x7PnL7LT+DLfMhNuMnyWmhcBbbg=";
            })
  

          ];
        });
 
        
        gnome-control-center = psuper.gnome-control-center.overrideAttrs (oldAttrs: {
          patches = oldAttrs.patches ++ [
            /*
            #varaiable refresh rate in settings
            
            (super.fetchpatch {
              url = "https://aur.archlinux.org/cgit/aur.git/plain/734.patch?h=gnome-control-center-vrr";
              hash = "sha256-8FGPLTDWbPjY1ulVxJnWORmeCdWKvNKcv9OqOQ1k/bE=";
            })
            */
          
          ];
        });
        
        
      });
    })
  ];
  

  #gnome
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;


  #bootloader
  boot = {    
    loader = {
      systemd-boot.enable = false;
      grub = {
        enable = true;
        efiSupport = true;
        useOSProber = true;
        #efiInstallAsRemovable = true; # in case canTouchEfiVariables doesn't work for your system
        device = "nodev";
      };
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
    };

  };


  #Hardware
  hardware = {
  
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        nvidia-vaapi-driver
        libva
      ];
    };

    nvidia = {
      modesetting.enable = true;
      open = false;
      nvidiaSettings = true;
      dynamicBoost.enable = true; 
      powerManagement.enable = true;
      powerManagement.finegrained = true;
      nvidiaPersistenced = true;

      
      prime = { 
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };

        amdgpuBusId = "PCI:7:0:0";
        nvidiaBusId = "PCI:1:0:0";

      };
    };
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  


  hardware.logitech.wireless.enable = true;
  

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Bluetooth
  # hardware.bluetooth.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  #networking
  networking = {
    
    hostName = "nixos"; # Define your hostname.
    networkmanager.enable = true;  # Easiest to use and most distros use this by default.
    #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    enableIPv6 = true;

    nat = {
      enable = true;
      enableIPv6 = true;
      externalInterface = "enp3s0";
      internalInterfaces = [ "wg0" ];
    };

    firewall = {
      enable = true;
      #allowedTCPPorts = [ 53 ];
      #allowedUDPPorts = [ 53 51820 ];
    };

    
  };
  

  #services.openssh = {
    #enable = true;
    #ports = [ 22552 ];
    #settings = {
      #PermitRootLogin = "no";
      #PasswordAuthentication = false;
      #KbdInteractiveAuthentication = false;
    #};
  #};


  #sound
  security.rtkit.enable = true;
  
  hardware.pulseaudio.enable = false;
  
  services.pipewire = {
    enable = true;
    audio.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };


  #time 
  time.timeZone = "America/New_York";

  i18n.defaultLocale = "en_US.UTF-8";
  console = { 
  font = "Lat2-Terminus16";
    keyMap = "us";
  };


  #users
  users.mutableUsers = true;
  # mkpasswd
  users.groups = {
    samuel.gid = 1000;
  };
  users.users.samuel = {
    isNormalUser = true;
    home = "/home/samuel";
    shell = pkgs.zsh;
    uid = 1000;
    group = "samuel";
    extraGroups = [ "wheel" "networkmanager" "libvirtd" ]; # Enable ‘sudo’ for the user.
  };

  #ps3 emulator bs can't use memory, always something
  security.pam.loginLimits = [
      {domain = "*";type = "hard";item = "memlock";value = "unlimited";}
      {domain = "*";type = "soft";item = "memlock";value = "unlimited";}
  ];



  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 15*1024;
  }];


  
  # sudo
  security.sudo = {
    enable = true;
    extraRules = [{
      commands = [
        {
        command = "${pkgs.systemd}/bin/systemctl suspend";
        options = [ "NOPASSWD" ];
        }
        {
        command = "${pkgs.systemd}/bin/reboot";
        options = [ "NOPASSWD" ];
        }
        {
        command = "${pkgs.systemd}/bin/poweroff";
        options = [ "NOPASSWD" ];
        }
      ];
      groups = [ "wheel" ];
    }];
  };








}
