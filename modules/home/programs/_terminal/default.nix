{ config
, lib
, pkgs
, ...
}:

let
  cfg = config.terminal;
  enable = cfg != null;
in
{
  options = {
    terminal = lib.mkOption {
      type = lib.types.enum [
        "alacritty"
        "foot"
        "kitty"
        "wezterm"
        null
      ];
      default = null;
      description = "The terminal emulator to use.";
    };
  };

  config = lib.mkIf enable {
    home.sessionVariables.TERMINAL = lib.getExe pkgs.${cfg};
  };
}
