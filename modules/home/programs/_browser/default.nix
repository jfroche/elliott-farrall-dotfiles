{ config
, lib
, ...
}:

let
  cfg = config.browser;
  enable = cfg != null;
in
{
  options = {
    browser = lib.mkOption {
      type = lib.types.enum [
        "firefox"
        "vivaldi"
        null
      ];
      default = null;
      description = "The web browser to use.";
    };
  };

  config = lib.mkIf enable {

  };
}
