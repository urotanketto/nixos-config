{
  description = "NixOS configuration for xenopus";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
  let
    system = "x86_64-linux";
  in
  {
    nixosConfigurations.xenopus = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./hosts/xenopus/configuration.nix
        ./hosts/xenopus/hardware-configuration.nix

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.users.urotanketto = import ./home/urotanketto/home.nix;
        }
      ];
    };
  };
}

