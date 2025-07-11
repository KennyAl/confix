# A minimal system config that forms the base for all other systems.
{
  config,
  lib,
  pkgs,
  ...
}:
{
  nixpkgs.config.allowUnfree = true;

  nix = {
    extraOptions = "download-buffer-size = 1073741824"; # 1 GiB
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  users.mutableUsers = false;

  programs.fish.enable = true;
  security.sudo-rs.enable = true;
  environment.systemPackages = with pkgs; [
    bat
    btop
    fd
    fish
    hydra-check
    git
    gitui
    helix
    moar
    nh
    nil
    nixfmt-rfc-style
    ripgrep
    xh
    zellij
  ];

  environment.variables.EDITOR = "hx";
  environment.shellAliases = {
    cat = "bat";
    gp = "git pull --rebase --autostash";
    less = "moar";
    wget = "xh";
    zj = "zellij";
  };

  system.stateVersion = "24.11";
}
