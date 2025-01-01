{ lib
, ...
}:

{
  options = {
    file-manager = lib.mkOption {
      type = lib.types.enum [
        "nemo"
        null
      ];
      default = null;
      description = "The file manager to use.";
    };
  };
}
