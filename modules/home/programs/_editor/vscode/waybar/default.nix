{ config
, lib
, ...
}:

let
  cfg = config.editor;
  enable = ((cfg == "vscode") || (cfg == "vscode-insiders")) && config.programs.waybar.enable;

  name = if cfg == "vscode" then "code" else "code-insiders";
in
{
  config = lib.mkIf enable {
    programs.waybar.settings.mainBar."hyprland/workspaces".window-rewrite = {
      "${name}" = "󰨞";
    };
  };
}
