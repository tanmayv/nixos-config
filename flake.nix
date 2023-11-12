{
  description = "Flake for building my gnome system";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-software-center.url = "github:vlinkz/nix-software-center";
    gnomeNixpkgs.url = "github:NixOS/nixpkgs/gnome";
  };

  outputs = { self, nixpkgs, gnomeNixpkgs, nix-software-center }@inputs: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./hardware-configuration.nix
          ./packages.nix  

          #{nixpkgs.overlays = [
            #(self: super: {
              #gnome = gnomeNixpkgs.legacyPackages.x86_64-linux.gnome;
            #})
          #];}        
         
        ];
        specialArgs = {
          inherit inputs;
        };
        
      };
    };

    

  };
}
