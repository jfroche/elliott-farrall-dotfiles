{ lib
, ...
}:

{
  options = {
    file-manager = lib.mkOption {
      description = "The file manager to use.";
      default = null;
      type = lib.types.enum [
        "nemo"
        null
      ];
    };
  };
}
