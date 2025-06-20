{ config, pkgs, ... }:
{
  imports = [
    ./essentials.nix
    ./ghostty/default.nix
    ./mako.nix
    ./starship/default.nix
  ];
}
