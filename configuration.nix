{ pkgs,config, ... }:

{


  system = {
    stateVersion = "23.05";
    activationScripts.linkBash = {
      text = ''
        ln -sf ${pkgs.bash}/bin/bash /bin/bash
      '';
    };

  };


  nix = {

    gc = {
	automatic = true;
	dates = "weekly";
	options = "--delete-older-than 14d";
    };

    #optimise.automatic = true;
    settings.experimental-features = [ "nix-command" "flakes" ];

  };





  environment = {
    shells = with pkgs; [ zsh bash dash ];
    binsh = "${pkgs.dash}/bin/dash";

    sessionVariables = rec {
      NIXOS_OZONE_WL = "1";
      XDG_CACHE_HOME = "$HOME/.cache";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME = "$HOME/.local/share";
      XDG_STATE_HOME = "$HOME/.local/state";

      # Not officially in the specification
      XDG_BIN_HOME = "$HOME/.local/bin";
      PATH = [
        "${XDG_BIN_HOME}"
      ];
    };

  };



  services = {

    xserver = {
      enable = true;
	xkb.options = "ctrl:nocaps";
      desktopManager.gnome.enable = true;
      displayManager.gdm = {
	enable = true;
	wayland = true;
      };
      videoDrivers = [ "nvidia" ];
            
    };

    #sound
    pipewire = {
      enable = true;
      audio.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };
    
    #touchpad
    libinput.enable = true;

    # Enable CUPS to print documents.
    #printing.enable = true;

    #openssh = {
    #enable = true;
    #ports = [ 22552 ];
    #settings = {
    #PermitRootLogin = "no";
    #PasswordAuthentication = false;
    #KbdInteractiveAuthentication = false;
    #};



  };


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


  hardware = {

    opengl = {
      enable = true;
      driSupport32Bit = true;

      extraPackages = with pkgs; [
        rocm-opencl-icd
        rocm-opencl-runtime
      ];

    };

    nvidia =  {
      package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
	    version = "550.120";
	    sha256_64bit = "sha256-gBkoJ0dTzM52JwmOoHjMNwcN2uBN46oIRZHAX8cDVpc=";
	    sha256_aarch64 = "sha256-mVEeFWHOFyhl3TGx1xy5EhnIS/nRMooQ3+LdyGe69TQ=";
	    openSha256 = "sha256-Po+pASZdBaNDeu5h8sgYgP9YyFAm9ywf/8iyyAaLm+w=";
	    settingsSha256 = "sha256-fPfIPwpIijoUpNlAUt9C8EeXR5In633qnlelL+btGbU=";
	    persistencedSha256 = "sha256-Vz33gNYapQ4++hMqH3zBB4MyjxLxwasvLzUJsCcyY4k=";
      };
      modesetting.enable = true;
      open = false;
      nvidiaSettings = true;
      dynamicBoost.enable = true;
      #powerManagement.enable = true;
      powerManagement.finegrained = true;
      #nvidiaPersistenced = true;


      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };

        amdgpuBusId = "PCI:65:0:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };

    #2 in 1 laptop
    sensor.iio.enable = true;

    logitech.wireless.enable = true;
    pulseaudio.enable = false;

    #Bluetooth
    #bluetooth.enable = true;

  };


  networking = {

    hostName = "nixos"; # Define your hostname.
    networkmanager.enable = true; # Easiest to use and most distros use this by default.
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



  #time 
  time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_US.UTF-8";

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };




  programs.zsh.enable = true;

  #users
  users = {
    mutableUsers = true;
    groups = {
      samuel.gid = 1000;
    };

    users.samuel = {
      isNormalUser = true;
      home = "/home/samuel";
      shell = pkgs.zsh;
      uid = 1000;
      group = "samuel";
      extraGroups = [ "wheel" "networkmanager" "gamemode" ]; # Enable ‘sudo’ for the user.
    };
  };



  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 32 * 1024;
  }];


  security = {

    sudo = {
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

    #emulator memory
    pam.loginLimits = [
      { domain = "*"; type = "hard"; item = "memlock"; value = "unlimited"; }
      { domain = "*"; type = "soft"; item = "memlock"; value = "unlimited"; }
    ];

    #sound
    rtkit.enable = true;

  };





}
