{ config
, lib
, ...
}:

let
  cfg = config.shell;
  enable = cfg == "zsh";
in
{
  config = lib.mkIf enable {
    programs.zsh.enable = true;
    environment.pathsToLink = [ "/share/zsh" ]; # Allows completion for system packages
  };
}
