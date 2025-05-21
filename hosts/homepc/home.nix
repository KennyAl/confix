{ config, pkgs, ... }:
{
  imports = [
    ../../home/desktop.nix
    ./home/kanshi.nix
  ];

  home = {
    username = "kenny";
    homeDirectory = "/home/kenny";
  };
}
