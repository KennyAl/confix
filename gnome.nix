# Gnome desktop config
{
  config,
  lib,
  pkgs,
  ...
}:
{
  # Enable the X11 windowing system.
  services.xserver.enable = true;
  programs.xwayland.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Not sure if this even works. Discord crashes stil while screensharing...
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gnome
    ];
  };
}
