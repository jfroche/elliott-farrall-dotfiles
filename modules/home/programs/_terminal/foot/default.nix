{ config
, lib
, ...
}:

let
  cfg = config.terminal;
  enable = cfg == "foot";
in
{
  config = lib.mkIf enable {
    programs.foot.enable = true;
  };
}
