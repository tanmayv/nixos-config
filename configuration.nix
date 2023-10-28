{ config, pkgs, ... }:

{


 


  system.stateVersion = "23.05";
  boot.kernelPackages = pkgs.linuxPackages_latest;
  
  nix.optimise.automatic = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  
  #boot.kernelModules = [];
}
