{ config, pkgs, ... }:
{
  imports = [
    ./btop/default.nix
    ./gdb.nix
    ./helix/default.nix
    ./zellij/default.nix
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.stateVersion = "25.05";
}
