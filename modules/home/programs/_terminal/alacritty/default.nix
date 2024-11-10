{ config
, lib
, ...
}:

let
  cfg = config.terminal;
  enable = cfg == "alacritty";
in
{
  config = lib.mkIf enable {
    programs.alacritty.enable = true;
  };
}
