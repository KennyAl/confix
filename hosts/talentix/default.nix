{
  config,
  lib,
  pkgs,
  ...
}:
let
  srapkgs =
    (builtins.getFlake "git+https://github.com/luhsra/srapkgs?ref=master&rev=57935fba66eb3557b833f8a377b0a1ed9d95dd35")
    .packages."x86_64-linux";
in
{
  imports = [
    ./hardware.nix
    ../../minimal-desktop.nix
    ../../gnome.nix
  ];

  config = {
    boot.supportedFilesystems = [ "zfs" ];
    boot.kernelPackages = pkgs.linuxPackages_latest;

    networking = {
      # We get this via dhcp
      hostName = "";
      # ZFS needs this
      hostId = "8f25e349";
      # networkmanager.enable = lib.mkforce false;
    };

    # Ignore closing of the lid when on external power
    services.logind = {
      lidSwitchExternalPower = "ignore";
      extraConfig = ''
        IdleAction=ignore
      '';
    };

    services.power-profiles-daemon.enable = false;
    services.tlp = {
      enable = true;
      settings = {
        PLATFORM_PROFILE_ON_AC = "performance";
        PLATFORM_PROFILE_ON_BAT = "low-power";

        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 0;

        START_CHARGE_THRESH_BAT0 = 40; # 40 and below it starts to charge
        STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging
      };
    };

    users.users.kenny = {
      isNormalUser = true;
      description = "kenny";
      extraGroups = [
        "wheel"
      ];
      shell = pkgs.fish;
      hashedPassword = "$y$j9T$umD3dZS306Wio/Q5LkbMm1$sD1vae2x18BpRCUMWEsYKIJ0Vg9xmUn04/cfj5AyJU/";
    };
    users.users.root.password = "";

    programs.thunderbird.enable = true;
    environment.systemPackages = with pkgs; [
      element-desktop
      obsidian
      pass
      srapkgs.sra-cli
      zotero
    ];

    nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 10d";
    };

    services.zfs = {
      # Default is monthly which should be enough
      autoScrub.enable = true;
      # Weekly trim
      trim.enable = true;
    };

    services.restic.backups.home = {
      passwordFile = "/home/kenny/.config/restic/keyfile";
      repositoryFile = "/home/kenny/.config/restic/repo";
      runCheck = true;
      # Otherwise the service does not find my ssh config
      user = "kenny";
      timerConfig = {
        OnCalendar = "*:0/30";
      };
      # Needs authentication
      inhibitsSleep = false;
      exclude = [
        ".git"
        # Exclude the contents of the `volatile` dir in home
        "/home/nixos/volatile"
        # Helix is setup with a large ngram file, ignore it
        "helix/lang"
        # Since restic does currently not support excluding files bases on .gitignore I have to maintain a list of the worst offenders
        # See https://github.com/restic/restic/issues/1514
        "*.qcow2"
        "*.img"
        "*.log"
        "*.o"
        "*.so"
        "*.a"
      ];
    };
  };
}
