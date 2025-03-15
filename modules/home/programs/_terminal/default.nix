{ lib
, pkgs
, config
, ...
}:

let
  cfg = config.terminal;
  enable = cfg != null;
in
{
  options = {
    terminal = lib.mkOption {
      description = "The terminal emulator to use.";
      default = null;
      type = lib.types.enum [
        "alacritty"
        "foot"
        "kitty"
        "wezterm"
        null
      ];
    };
  };

  config = lib.mkIf enable {
    home.sessionVariables.TERMINAL = lib.getExe pkgs.${cfg};
  };
}
