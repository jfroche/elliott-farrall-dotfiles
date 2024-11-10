{ config
, lib
, ...
}:

let
  cfg = config.programs.minecraft;
  inherit (cfg) enable;
in
{
  config = lib.mkIf enable {
    home.activation = {
      linkJava = lib.internal.mkLinkScript "${config.xdg.configHome}/java" "${config.home.homeDirectory}/.java";
      linkMinecraft = lib.internal.mkLinkScript "${config.xdg.dataHome}/minecraft" "${config.home.homeDirectory}/.minecraft";
      linkMputils = lib.internal.mkLinkScript "${config.xdg.dataHome}/mputils" "${config.home.homeDirectory}/.mputils";
    };
  };
}
