{ osConfig ? null
, lib
, ...
}:

{
  options = {
    display = {
      enable = lib.mkEnableOption "display configuration" // { default = osConfig.display.enable or true; };
      output = lib.mkOption {
        description = "Output of the display.";
        type = lib.types.str;
        default = osConfig.display.output or "eDP-1";
      };
      width = lib.mkOption {
        description = "Width of the display.";
        type = lib.types.int;
        default = osConfig.display.width or 1920;
      };
      height = lib.mkOption {
        description = "Height of the display.";
        type = lib.types.int;
        default = osConfig.display.height or 1080;
      };
      refresh = lib.mkOption {
        description = "Refresh rate of the display.";
        type = lib.types.int;
        default = osConfig.display.refresh or 60;
      };
      scale = lib.mkOption {
        description = "Scale of the display.";
        type = lib.types.float;
        default = osConfig.display.scale or 1.0;
      };
    };
  };
}
