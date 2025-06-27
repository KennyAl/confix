{ config, pkgs, ... }:
{
  imports = [
    ../wofi/default.nix
  ];

  xdg.configFile = {
    "niri/config.kdl".source = ./config.kdl;
    "niri/wallpaper.jpg".source = ./tn-glados-better.jpg;
  };
}
