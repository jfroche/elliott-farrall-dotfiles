{ config
, lib
, pkgs
, ...
}:

let
  cfg = config.desktop.hyprland;
  inherit (cfg) enable;

  package = pkgs.symlinkJoin {
    name = "rofi";
    paths = [ pkgs.rofi-wayland ];
    postBuild = ''
      install -v ${pkgs.rofi-wayland}/share/applications/rofi.desktop $out/share/applications/rofi.desktop
      echo 'NoDisplay=true' >> $out/share/applications/rofi.desktop
      install -v ${pkgs.rofi-wayland}/share/applications/rofi-theme-selector.desktop $out/share/applications/rofi-theme-selector.desktop
      echo 'NoDisplay=true' >> $out/share/applications/rofi-theme-selector.desktop
    '';
  };
in
{
  config = lib.mkIf enable {
    programs.rofi = {
      enable = true;
      inherit package;
      plugins = with pkgs.rofi-plugins; [
        rofi-logout
      ];
      terminal = config.home.sessionVariables.TERMINAL or null;

      cycle = true;
      extraConfig = {
        sidebar-mode = true;
        modes = [ "drun" "window" ];
        display-drun = " 󰵆  Apps ";
        display-run = "   Run ";
        display-window = "   Window";
        # display-Network = " 󰤨  Network";

        dpi = 120;
        show-icons = true;
        icon-theme = config.stylix.iconTheme.${config.stylix.polarity};
        drun-display-format = "{name}";

        hover-select = true;
        click-to-exit = true; # Broken
        steal-focus = true;
      };
    };
  };
}
