{ config, pkgs, ... }:
{
  programs.btop = {
    enable = true;
    extraConfig = builtins.readFile ./btop.conf;
    themes.tokyonight-storm = ./tokyonight-storm.theme;
  };
  xdg.configFile."btop/btop.conf".source= ./btop.conf;
}
