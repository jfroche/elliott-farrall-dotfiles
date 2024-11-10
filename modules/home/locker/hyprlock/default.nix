{ osConfig
, config
, lib
, ...
}:

let
  cfg = config.locker;
  enable = cfg == "hyprlock";
in
{
  config = lib.mkIf enable {
    assertions = [
      (lib.mkIf (osConfig != null) {
        assertion = osConfig.programs.hyprlock.enable;
        message = "Please enable hyprlock in nixos configuration";
      })
    ];

    programs.hyprlock.enable = true;
  };
}
