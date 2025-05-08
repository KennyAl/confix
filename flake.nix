{
  description = "My nixos configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    # home-manager.url = "github:nix-community/home-manager";
    # home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    { self, nixpkgs, ... }@attrs:
    {
      nixosConfigurations.home = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        # specialArgs = attrs;
        modules = [ ./homepc.nix ];
      };
      nixosConfigurations.talentix = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        # specialArgs = attrs;
        modules = [ ./talentix.nix ];
      };
    };
}
