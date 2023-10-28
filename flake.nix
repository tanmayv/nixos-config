{
  description = "A very basic flake";

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
          ./hardware.nix
          ./network.nix
          ./packages.nix
          ./users.nix
          ./environment.nix
          ./graphical_environment.nix
          ./sound.nix
          ./time_locale.nix

        ];
        specialArgs = {
          inherit inputs;
        };
        
      };
    };

    

  };
}
