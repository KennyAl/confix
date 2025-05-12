{ config, pkgs, ... }:
{
  programs.helix = {
    enable = true;
    themes.my-tn-storm = ./my-tn-storm.toml;
  };
  xdg.configFile = {
    "helix/config.toml".source = ./config.toml;
    "helix/languages.toml".source = ./languages.toml;
  };
}
