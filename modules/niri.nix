# Niri desktop config
{
  config,
  lib,
  pkgs,
  ...
}:
let
  spawnAtStartup = exec: {
    partOf = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    requisite = [ "graphical-session.target" ];
    wantedBy = [ "niri.service" ];

    serviceConfig = {
      ExecStart = exec;
      Restart = "on-failure";
    };
  };
in
{
  programs.niri.enable = true;
  environment.systemPackages = with pkgs; [
    hyprlock
    wofi
    xwayland-satellite
  ];

  systemd.user.services = {
    # TODO: Fix this once there is a home manger module and I port this
    swaybg = spawnAtStartup "${lib.getExe pkgs.swaybg} -i /home/kenny/.config/niri/wallpaper.jpg";
  };

  # Polkit auth agent
  security.soteria.enable = true;

  # Remove this once we get rid of the gnome module completely
  services.displayManager.gdm.enable = lib.mkForce false;
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd}/bin/agreety --cmd niri-session";
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
