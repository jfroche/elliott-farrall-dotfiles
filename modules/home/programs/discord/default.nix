{ config
, lib
, pkgs
, ...
}:

let
  cfg = config.programs.discord;
  inherit (cfg) enable;
in
{
  options = {
    programs.discord.enable = lib.mkEnableOption "Discord";
  };

  config = pkgs.lib.mkIf enable {
    home.packages = [
      (pkgs.discord.overrideAttrs (attrs: {
        desktopItem = attrs.desktopItem.override {
          noDisplay = true;
        };
      }))
      (pkgs.vesktop.overrideAttrs (attrs: {
        desktopItems = [
          ((lib.lists.findFirst (_: true) null attrs.desktopItems).override {
            desktopName = "Discord";
            icon = "discord";
          })
        ];
      }))
    ];

    xdg.configFile."vesktop/settings/settings.json" = {
      text = ''
        {
          "themeLinks": [
            "https://catppuccin.github.io/discord/dist/catppuccin-macchiato-pink.theme.css"
          ]
        }
      '';
      force = true;
    };
  };
}
