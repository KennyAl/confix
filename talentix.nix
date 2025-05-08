{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./minimal-desktop.nix
    ./gnome.nix
  ];

  config = {
    boot.supportedFilesystems = [ "zfs" ];
    boot.kernelPackages = pkgs.linuxPackages_latest;

    networking = {
      # We get this via dhcp
      hostName = "";
      # networkmanager.enable = lib.mkforce false;
    };

    users.users.kenny = {
      isNormalUser = true;
      description = "kenny";
      extraGroups = [
        "wheel"
      ];
      shell = pkgs.fish;
    };

    environment.systemPackages = with pkgs; [
      pass
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
      timerConfig = "*:0/30";
      inhibitsSleep = true;
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
