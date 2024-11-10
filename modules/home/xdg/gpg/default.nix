{ config
, lib
, ...
}:

let
  cfg = config.xdg;
  inherit (cfg) enable;
in
{
  config = lib.mkIf enable {
    programs.gpg.homedir = "${config.xdg.dataHome}/gnupg";
  };
}
