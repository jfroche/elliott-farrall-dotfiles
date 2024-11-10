{ config
, lib
, ...
}:

let
  cfg = config.greeter;
  enable = cfg != null;
in
{
  options = {
    greeter = lib.mkOption {
      type = lib.types.enum [
        "tuigreet"
        null
      ];
      default = null;
      description = "The greeter to use.";
    };
  };

  config = lib.mkIf enable {
    services.greetd.enable = true;
  };
}
