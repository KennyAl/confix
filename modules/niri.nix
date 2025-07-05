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
    hyprlock
    kanshi
    swaybg
    wofi
    xwayland-satellite
  ];

  # Polkit auth agent
  security.soteria.enable = true;

  # Remove this once we get rid of the gnome module completely
  services.displayManager.gdm.enable = lib.mkForce false;
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.greetd}/bin/agreety --cmd niri-session";
      };
    };
  };

  # Except xdgOpenUsePortal this is all set by the niri module anyway, but lets be explicit
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gnome
    ];
  };
}
