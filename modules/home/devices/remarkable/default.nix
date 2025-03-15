{ lib
, pkgs
, config
, ...
}:

let
  cfg = config.devices.remarkable;
  inherit (cfg) enable;

  desktopItem = pkgs.makeDesktopItem {
    name = "rmview";
    exec = "rmview";
    icon = builtins.fetchurl {
      url = "https://dotfiles.beannet.io/icons/remarkable.jpeg";
      sha256 = "sha256:1dprfaslqvwhn7iphigjrf6a0zwc5idi62bmrqzagvfvi2r0lb9d";
    };
    comment = "A live viewer for reMarkable written in PyQt5";
    desktopName = "reMarkable";
  };

  package = pkgs.symlinkJoin {
    name = "rmview";
    paths = with pkgs; [
      rmview
    ];
    postBuild = ''
      install -Dm444 -t $out/share/applications ${desktopItem}/share/applications/*
    '';
  };
in
{
  options = {
    devices.remarkable.enable = lib.mkEnableOption "reMarkable";
  };

  config = lib.mkIf enable {
    home.packages = [ package ];
  };
}
