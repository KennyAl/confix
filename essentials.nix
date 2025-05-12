# Set of base tools that I want everywhere.
{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.fish.enable = true;
  security.sudo-rs.enable = true;
  environment.systemPackages = with pkgs; [
    bat
    btop
    fd
    fish
    git
    gitui
    helix
    moar
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
}
