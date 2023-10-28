{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./hardware.nix
      ./network.nix
      ./packages.nix
      ./users.nix
      ./environment.nix
      ./graphical_environment.nix
      ./sound.nix
      ./time_locale.nix
      
   ];

 
  system.stateVersion = "23.05";
  system.copySystemConfiguration = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  
  nix.optimise.automatic = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  
  #boot.kernelModules = [];
}
