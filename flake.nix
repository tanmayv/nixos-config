{
  description = "Flake for building my gnome system";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-software-center.url = "github:vlinkz/nix-software-center";
  };

  outputs = { self, nixpkgs, nix, nix-software-center }@inputs: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./hardware-configuration.nix
          ./packages.nix          
         
        ];
        specialArgs = {
          inherit inputs;
        };
        
      };
    };

    

  };
}
