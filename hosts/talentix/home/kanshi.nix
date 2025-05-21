{ config, pkgs, ... }:
{
  services.kanshi = {
    enable = true;
    profiles =
      let
        integrated = {
          criteria = "LG Display 0x06ED Unknown";
          mode = "1920x1200";
          status = "enable";
          scale = 1.0;
          position = "0,0";
        };
      in
      {
        mobile = {
          outputs = [
            integrated
          ];
        };
        office = {
          outputs = [
            integrated
            {
              criteria = "Dell Inc. DELL U2715H GH85D76G11ES";
              mode = "2560x1440";
              position = "1920,0";
              status = "enable";
              scale = 1.0;
            }
            {
              criteria = "Dell Inc. DELL P2723DE 6R420N3";
              mode = "2560x1440";
              position = "${builtins.toString (2560 + 1920)},0";
              status = "enable";
              scale = 1.0;
            }
          ];
        };
      };
  };
}
