{ config, pkgs, ... }:
{
  imports = [
    ../../home/desktop.nix
  ];

  home = {
    username = "kenny";
    homeDirectory = "/home/kenny";
  };
}
