{ lib
, pkgs
, config
, ...
}:

let
  cfg = config.file-manager;
  enable = cfg == "nemo";
in
{
  config = lib.mkIf enable {
    home.packages = with pkgs; [
      nemo-with-extensions
      nemo-fileroller
    ];
  };
}
