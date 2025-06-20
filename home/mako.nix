{ config, pkgs, ... }:
{
  services.mako = {
    enable = true;
    settings = {
      default-timeout = (10 * 1000); # 10 seconds
    };
  };
}
