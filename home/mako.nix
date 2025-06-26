{ config, pkgs, ... }:
{
  services.mako = {
    enable = true;
    settings = {
      default-timeout = (10 * 1000); # 10 seconds
      background-color = "#2F334D";
      border-color = "#C099FF";
      border-radius = 8;
    };
  };
}
