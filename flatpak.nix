# Enable flatpak support and register flathub as a repo
{
  config,
  lib,
  pkgs,
  ...
}:
{
  services.flatpak.enable = true;
  # TODO: Could this be an activation script or does that only work for a single user?
  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };

}
