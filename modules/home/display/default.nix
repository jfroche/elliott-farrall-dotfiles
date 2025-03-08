{ osConfig ? null
, lib
, ...
}:

{
  options = {
    display = {
      enable = lib.mkEnableOption "display configuration";
      output = lib.mkOption {
        description = "Output of the display.";
        type = lib.types.str;
        default = "eDP-1";
      };
      width = lib.mkOption {
        description = "Width of the display.";
        type = lib.types.int;
        default = osConfig.display.width or 1920;
      };
      height = lib.mkOption {
        description = "Height of the display.";
        type = lib.types.int;
        default = osConfig.display.width or 1080;
      };
      refresh = lib.mkOption {
        description = "Refresh rate of the display.";
        type = lib.types.int;
        default = osConfig.display.width or 60;
      };
      scale = lib.mkOption {
        description = "Scale of the display.";
        type = lib.types.float;
        default = osConfig.display.width or 1.0;
      };
    };
  };

  config = lib.optionalAttrs (osConfig != null) {
    inherit (osConfig) display;
  };
}
