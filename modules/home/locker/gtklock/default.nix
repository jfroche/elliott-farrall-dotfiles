{ osConfig
, config
, lib
, pkgs
, ...
}:

let
  cfg = config.locker;
  enable = cfg == "gtklock";
in
{
  config = lib.mkIf enable {
    assertions = [
      (lib.mkIf (osConfig != null) {
        assertion = osConfig.programs.gtklock.enable;
        message = "Please enable gtklock in nixos configuration";
      })
    ];

    home.packages = with pkgs; [ gtklock ];
  };
}
