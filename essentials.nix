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
  environment.shellAliases = {
    cat = "bat";
    less = "moar";
    wget = "xh";
  };
}
