{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./homepc-hardware.nix
    ./flatpak.nix
    ./minimal-desktop.nix
    ./gnome.nix
  ];

  config = {
    boot.supportedFilesystems = [ "ntfs" ];
    boot.kernelPackages = pkgs.linuxPackages_latest;

    hardware.graphics.enable = true;
    hardware.nvidia.nvidiaSettings = true;
    hardware.nvidia = {
      modesetting.enable = true;
      # The new module works better with wayland, but sets my fans to 100% speed...
      open = false;
    };
    services.xserver.videoDrivers = [ "nvidia" ];

    networking = {
      hostName = "home";
      # TODO: Switch to networkd once my network is sorted out...
      networkmanager.enable = true;
    };

    users.users.kenny = {
      isNormalUser = true;
      description = "kenny";
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
      shell = pkgs.fish;
    };

    programs.steam.enable = true;
    programs.gamescope.enable = true;
    programs.steam.gamescopeSession.enable = true;
    environment.systemPackages = with pkgs; [
      keymapp
    ];
  };
}
