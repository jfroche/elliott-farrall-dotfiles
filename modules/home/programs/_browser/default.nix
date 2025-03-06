{ lib
, ...
}:

{
  options = {
    browser = lib.mkOption {
      description = "The web browser to use.";
      default = null;
      type = lib.types.enum [
        "firefox"
        "vivaldi"
        null
      ];
    };
  };
}
