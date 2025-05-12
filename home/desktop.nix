{ config, pkgs, ... }:
{
  imports = [
    ./essentials.nix
    ./ghostty/default.nix
    ./starship/default.nix
  ];
}
