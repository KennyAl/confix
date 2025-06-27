{ config, pkgs, ... }:
{
  programs.wofi = {
    enable = true;
    settings = {
      width = "20%";
      insensitive = true;
      # This does not seem to work. Likely because of the custom style?
      dynamic_lines = true;
    };
    style = ./style.css;
  };
}
