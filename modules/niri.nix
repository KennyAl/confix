# Niri desktop config
{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.niri.enable = true;
  environment.systemPackages = with pkgs; [
    kanshi
    wofi
    xwayland-satellite
  ];

  # Except xdgOpenUsePortal this is all set by the niri module anyway, but lets be explicit 
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gnome
    ];
  };
}
