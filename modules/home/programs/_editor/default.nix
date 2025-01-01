{ lib
, ...
}:

{
  options = {
    editor = lib.mkOption {
      type = lib.types.enum [
        "vscode"
        "vscode-insiders"
        null
      ];
      default = null;
      description = "The text editor to use.";
    };
  };
}
