{ config, pkgs, ... }:
{
  xdg.configFile."soteria/style.css".source= ./style.css;
}
