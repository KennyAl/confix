{
  description = "My nixos configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self, nixpkgs, home-manager, ... }@attrs:
    {
      nixosConfigurations.home = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        # specialArgs = attrs;
        modules = [
          ./homepc.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.kenny = ./homepc-home.nix;
            };
          }
        ];
      };
      nixosConfigurations.talentix = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        # specialArgs = attrs;
        modules = [
          ./talentix.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.jdoe = ./talentix-home.nix;
            };
          }
        ];
      };
    };
}
