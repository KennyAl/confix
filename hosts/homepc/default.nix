{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/flatpak.nix
    ../../modules/minimal-desktop.nix
    ../../modules/gnome.nix
    ../../modules/niri.nix
  ];

  config = {
    boot.supportedFilesystems = [ "ntfs" ];
    boot.kernelPackages = pkgs.linuxPackages_latest;

    boot = {
      extraModulePackages = with config.boot.kernelPackages; [
        v4l2loopback
      ];
      extraModprobeConfig = ''
        options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
      '';
    };

    hardware.graphics.enable = true;
    hardware.nvidia.nvidiaSettings = true;
    hardware.nvidia = {
      modesetting.enable = true;
      open = true;
    };
    services.xserver.videoDrivers = [ "nvidia" ];

    networking = {
      hostName = "home";
      # TODO: Switch to networkd once my network is sorted out...
      networkmanager.enable = true;
      wg-quick.interfaces.wghi = {
        configFile = "/etc/wireguard/wghi.conf";
        autostart = false;
      };
    };

    # This fixes the windows clock as it also stores local time instead of UTC
    time.hardwareClockInLocalTime = true;

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

    programs = {
      gamescope.enable = true;
      steam = {
        enable = true;
        gamescopeSession.enable = true;
        extraCompatPackages = with pkgs; [
          proton-ge-bin
        ];
      };
    };

    # This is a temporary fix for proton-vpn unitl there is a module that adds this
    # See: https://github.com/NixOS/nixpkgs/issues/425431
    # TODO: Remove once fixed upstream
    networking.networkmanager.plugins = with pkgs; [ networkmanager-openvpn ];
    environment.systemPackages = with pkgs; [
      easyeffects
      keymapp
      obs-studio
      # This segaults on first start under wayland, see https://github.com/NixOS/nixpkgs/issues/365156
      # Got this working by launching with --ozone-platform-hint=x11 once.
      protonmail-desktop
      protonvpn-gui
      tidal-hifi
      vdhcoapp
      vlc
    ];
  };
}
