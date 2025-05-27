{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../../flatpak.nix
    ../../minimal-desktop.nix
    ../../gnome.nix
    ../../niri.nix
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
      wg-quick.interfaces.wghi.configFile = "/etc/wireguard/wghi.conf";
    };

    # Default interval is weekly
    services.fstrim.enable = true;

    users.users.kenny = {
      isNormalUser = true;
      description = "kenny";
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
      hashedPassword = "$y$j9T$jK2jk4b2hxgYSswnVmNm/.$1GPMwgzdd4rMvWOktePLOHKxRbOaZq1an9.eGIpmkQ8";
      shell = pkgs.fish;
    };
    users.users.root.hashedPassword = "$y$j9T$jK2jk4b2hxgYSswnVmNm/.$1GPMwgzdd4rMvWOktePLOHKxRbOaZq1an9.eGIpmkQ8";

    programs.steam.enable = true;
    programs.gamescope.enable = true;
    programs.steam.gamescopeSession.enable = true;
    environment.systemPackages = with pkgs; [
      keymapp
      protonvpn-gui
    ];
  };
}
