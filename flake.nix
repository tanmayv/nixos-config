{
  description = "Flake for building my gnome system";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/master";
    nix-software-center.url = "github:vlinkz/nix-software-center";
  };

  outputs = inputs: {
    nixosConfigurations = {
      nixos = inputs.nixpkgs.lib.nixosSystem {
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
