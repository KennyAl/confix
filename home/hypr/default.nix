{ config, pkgs, ... }:
{
  xdg.configFile."hypr/hyprlock.conf".source = ./hyprlock.conf;
}
