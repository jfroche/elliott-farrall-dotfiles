{ lib
, config
, ...
}:

let
  cfg = config.terminal;
  enable = cfg == "wezterm";
in
{
  config = lib.mkIf enable {
    programs.wezterm.enable = true;
  };
}
