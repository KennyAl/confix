{ config, pkgs, ... }:
{
  xdg.configFile."gdb/gdbinit".text = ''
    set auto-load safe-path /
    set disassembly-flavor intel
  '';
}
