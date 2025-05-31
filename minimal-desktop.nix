# Stuff I want in every desktop system, regardless of the window manager
{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [ ./minimal.nix ];

  config = {
    services.xserver.xkb = {
      layout = "us";
      variant = "";
    };

    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    programs.firefox.enable = true;
    programs.starship.enable = true;
    environment.systemPackages = with pkgs; [
      cascadia-code
      ghostty
      starship
    ];
  };
}
