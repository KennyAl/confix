{
  description = "My nixos configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self, nixpkgs, nixos-hardware, home-manager, ... }@attrs:
    {
      nixosConfigurations.home = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        # specialArgs = attrs;
        modules = [
          ./hosts/homepc/default.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.kenny = ./hosts/homepc/home.nix;
            };
          }
        ];
      };
      nixosConfigurations.talentix = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        # specialArgs = attrs;
        modules = [
          ./hosts/talentix/default.nix
          nixos-hardware.nixosModules.lenovo-thinkpad-x1-12th-gen
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.kenny = ./hosts/talentix/home.nix;
            };
          }
        ];
      };
    };
}
