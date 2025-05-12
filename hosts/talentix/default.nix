{
  config,
  lib,
  pkgs,
  ...
}:
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
      zotero
    ];

    nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 10d";
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
