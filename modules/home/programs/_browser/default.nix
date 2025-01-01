{ lib
, ...
}:

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
}
