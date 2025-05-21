{ config, pkgs, ... }:
{
  services.kanshi = {
    enable = true;
    profiles =
      {
        default = {
          outputs = [
            {
              criteria = "PNP(BNQ) ZOWIE XL LCD 52H00916SL0";
              mode = "2560x1440@143.856";
              position = "0,0";
              status = "enable";
              scale = 1.0;
            }
            {
              criteria = "PNP(BNQ) BenQ GL2250H A9G06456019";
              mode = "1920x1080@60.000";
              position = "2560,0";
              status = "enable";
              scale = 1.0;
            }
          ];
        };
      };
  };
}
