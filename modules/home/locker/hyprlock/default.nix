{ lib
, config
, osConfig ? null
, ...
}:

let
  cfg = config.locker;
  enable = cfg == "hyprlock";
in
{
  config = lib.mkIf enable {
    assertions = [
      {
        assertion = osConfig.programs.hyprlock.enable or true;
        message = "Please enable hyprlock in nixos configuration";
      }
    ];

    programs.hyprlock.enable = true;
  };
}
