{ config, pkgs, ... }:
{
  # This has no support for layouts, so we have to do everything manually
  programs.zellij.enable = true;
  xdg.configFile = {
    "zellij/config.kdl".source = ./config.kdl;
    "zellij/layouts" = {
      source = ./layouts;
      recursive = true;
    };
  };
}
