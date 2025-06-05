{
  description = "Nixos config for my work laptop";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixos-hardware,
      home-manager,
      ...
    }@attrs:
    {
      nixosConfigurations.talentix = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        # specialArgs = attrs;
        modules = [
          ./default.nix
          nixos-hardware.nixosModules.lenovo-thinkpad-x1-12th-gen
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.kenny = ./home.nix;
            };
          }
        ];
      };
    };
}
