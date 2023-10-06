{ config, lib, pkgs, ... }:

{
  
  boot = { 
    
    swraid.enable = false;

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

  
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      nvidia-vaapi-driver
      vaapiVdpau
    ];
  };

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
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

  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;



  systemd.services.onbattery = {
    script = ''
      export NIX_GSETTINGS_OVERRIDES_DIR=/nix/store/5m986d21kpxw64gk4vjba8hd5vvi26dy-gnome-settings-daemon-44.1/share/gsettings-schemas/gnome-settings-daemon-44.1/glib-2.0/schemas

      gsettings="/run/current-system/sw/bin/gsettings"
      cat="/run/current-system/sw/bin/cat"
      powerprofilesctl="/run/current-system/sw/bin/powerprofilesctl"


      while true; do
        # Check if we're running on battery
        battery0_state=$($cat /sys/class/power_supply/AC0/online)

        if [ "$battery0_state" = "0" ]; then
            #Running on battery power
      
            # Set power mode to quiet/powersaving
            $powerprofilesctl set power-saver

            $gsettings set org.gnome.desktop.session idle-delay 60

        else
            #Not running on battery power

            # Set power mode to quiet/powersaving
            $powerprofilesctl set balanced

            $gsettings set org.gnome.desktop.session idle-delay 300

            
        fi

        # Sleep for 5 seconds before the next iteration
        sleep 5
      done

    '';
    wantedBy = [ "multi-user.target" ];

  };
  


  #logitech shit
  hardware.logitech.wireless.enable = true;
  hardware.logitech.wireless.enableGraphical = true; # for solaar to be included
  

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Bluetooth
  # hardware.bluetooth.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;
}
