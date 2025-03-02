{ config
, lib
, ...
}:

let
  cfg = config.desktop.hyprland;
  inherit (cfg) enable;

  inherit (config.lib.formats.rasi) mkLiteral;

  inherit (config.lib.stylix) colors;
  inherit (config.stylix) fonts;

  accent = colors.${config.catppuccin.accentBase16};
in
{
  config = lib.mkIf enable {
    programs.rofi.font = lib.mkForce "${fonts.serif.name} ${toString fonts.sizes.popups}";

    programs.rofi.theme = {
      "*" = {
        accent = mkLiteral "#${accent}";

        selected-normal-background = lib.mkForce (mkLiteral "@background");
        selected-active-background = lib.mkForce (mkLiteral "@background");
        alternate-normal-background = lib.mkForce (mkLiteral "@background");

        selected-normal-text = lib.mkForce (mkLiteral "@accent");
        selected-active-text = lib.mkForce (mkLiteral "@accent");
        active-text = lib.mkForce (mkLiteral "@foreground");

        width = 600;
      };

      "window" = {
        height = mkLiteral "360px";
        border = mkLiteral "3px";
        border-radius = mkLiteral "10px";
        border-color = mkLiteral "@background";
      };

      "inputbar" = {
        children = map mkLiteral [ "prompt" "entry" ];
        padding = mkLiteral "2px";
        border-radius = mkLiteral "5px";
      };

      "prompt" = {
        padding = mkLiteral "6px";
        margin = mkLiteral "20px 0px 0px 20px";
        border-radius = mkLiteral "3px";
        background-color = mkLiteral "@accent";
        text-color = lib.mkForce (mkLiteral "@background");
      };

      "textbox-prompt-colon" = {
        expand = false;
        str = ":";
      };

      "entry" = {
        padding = mkLiteral "6px";
        margin = mkLiteral "20px 0px 0px 10px";
      };

      "listview" = {
        border = mkLiteral "0px 0px 0px";
        padding = mkLiteral "6px 0px 0px";
        margin = mkLiteral "10px 0px 0px 20px";
        columns = 2;
        lines = 5;
      };

      "element" = {
        padding = mkLiteral "5px";
      };

      "element-icon" = {
        size = mkLiteral "25px";
      };

      "mode-switcher" = {
        spacing = 0;
      };

      "button" = {
        padding = mkLiteral "10px";
        vertical-align = mkLiteral "0.5";
        horizontal-align = mkLiteral "0.5";
      };

      "message" = {
        padding = mkLiteral "2px";
        margin = mkLiteral "2px";
        border-radius = mkLiteral "5px";
      };

      "textbox" = {
        padding = mkLiteral "6px";
        margin = mkLiteral "20px 0px 0px 20px";
      };
    };
  };
}
