{ config, pkgs, ... }:
{
  home.shell.enableFishIntegration = true;
  programs.starship = {
    enable = true;
  };
  xdg.configFile."starship/starship.toml".source = ./starship.toml;
}
