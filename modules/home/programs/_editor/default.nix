{ lib
, ...
}:

{
  options = {
    editor = lib.mkOption {
      description = "The text editor to use.";
      default = null;
      type = lib.types.enum [
        "vscode"
        "vscode-insiders"
        null
      ];
    };
  };
}
