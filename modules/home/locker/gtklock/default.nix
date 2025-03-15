{ lib
, pkgs
, config
, osConfig ? null
, ...
}:

let
  cfg = config.locker;
  enable = cfg == "gtklock";
in
{
  config = lib.mkIf enable {
    assertions = [
      {
        assertion = osConfig.programs.gtklock.enable or true;
        message = "Please enable gtklock in nixos configuration";
      }
    ];

    home.packages = with pkgs; [ gtklock ];
  };
}
