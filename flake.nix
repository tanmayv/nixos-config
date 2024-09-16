{
  description = "Flake for building my gnome system";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";

    nixvim.url = "github:nix-community/nixvim/nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = inputs@{ nixpkgs, home-manager, nixvim, ... }: {
    nixosConfigurations = {
      nixos = inputs.nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
	  ./kernel.nix
          /etc/nixos/hardware-configuration.nix
          ./packages.nix

          #relies on nixvim input 
          ./neovim.nix

	  ./virtualization.nix

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users = {
                samuel = import ./home.nix;
              };
            };
          }

        ];


      };
    };

  };


}
