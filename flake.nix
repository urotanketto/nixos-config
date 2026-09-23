{
  description = "Personal NixOS configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    
    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nur.url = "github:nix-community/NUR";
    nur.inputs.nixpkgs.follows = "nixpkgs";

    private-config.url =
      "git+ssh://git@github.com/urotanketto/nixos-private.git";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nur,
    private-config,
    ...
  }:
  let
    system = "x86_64-linux";
  in
  {
    nixosConfigurations.xenopus = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        nur.modules.nixos.default

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

    nixosConfigurations.pombe = nixpkgs.lib.nixosSystem {
      inherit system;

      modules = [
        ./hosts/pombe/configuration.nix
        private-config.nixosModules.pombe-network

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.users.urotanketto = 
            import ./home/urotanketto/home-pombe.nix;
        }
      ];
    };
  };
}

