{ lib
, osConfig ? null
, ...
}:

{
  options = {
    locker = lib.mkOption {
      type = lib.types.enum [
        "gtklock"
        "hyprlock"
        null
      ];
      default = null;
      description = "The locker to use.";
    };
  };

  config = lib.mkIf (osConfig != null) {
    inherit (osConfig) locker;
  };
}
