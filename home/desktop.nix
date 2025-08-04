{ config, pkgs, ... }:
{
  imports = [
    ./essentials.nix
    ./ghostty/default.nix
    ./hypr/default.nix
    ./mako.nix
    ./starship/default.nix
  ];
}
