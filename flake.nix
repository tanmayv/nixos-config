{
  description = "Flake for building my gnome system";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-software-center.url = "github:vlinkz/nix-software-center";
    home-manager.url = "github:nix-community/home-manager";
  };

  outputs = inputs: {
    nixosConfigurations = {
      nixos = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./hardware-configuration.nix
          ./packages.nix  
          ./home.nix
        ];
        specialArgs = {
          inherit inputs;
        };
        
      };
    };

    

  };
}
