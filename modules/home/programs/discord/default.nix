{ lib
, pkgs
, config
, ...
}:

let
  cfg = config.programs.discord;
  inherit (cfg) enable;

  discord = pkgs.discord.overrideAttrs (attrs: {
    desktopItem = attrs.desktopItem.override {
      noDisplay = true;
    };
  });

  vesktop = pkgs.vesktop.overrideAttrs (attrs: {
    desktopItems = [
      ((lib.lists.findFirst (_: true) null attrs.desktopItems).override {
        desktopName = "Discord";
        icon = "discord";
      })
    ];
  });
in
{
  options = {
    programs.discord.enable = lib.mkEnableOption "Discord";
  };

  config = pkgs.lib.mkIf enable {
    home.packages = [
      discord
      vesktop
    ];
  };
}
