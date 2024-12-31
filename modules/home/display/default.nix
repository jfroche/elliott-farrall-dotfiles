{ osConfig ? null
, lib
, ...
}:

{
  options = {
    display = {
      enable = lib.mkEnableOption "display configuration";
      output = lib.mkOption {
        type = lib.types.str;
        default = "eDP-1";
        description = "Output of the display.";
      };
      width = lib.mkOption {
        type = lib.types.int;
        default = if osConfig != null then osConfig.display.width else 1920;
        description = "Width of the display.";
      };
      height = lib.mkOption {
        type = lib.types.int;
        default = if osConfig != null then osConfig.display.width else 1080;
        description = "Height of the display.";
      };
      refresh = lib.mkOption {
        type = lib.types.int;
        default = if osConfig != null then osConfig.display.width else 60;
        description = "Refresh rate of the display.";
      };
      scale = lib.mkOption {
        type = lib.types.float;
        default = if osConfig != null then osConfig.display.width else 1.0;
        description = "Scale of the display.";
      };
    };
  };

  config = lib.optionalAttrs (osConfig != null) {
    inherit (osConfig) display;
  };
}
