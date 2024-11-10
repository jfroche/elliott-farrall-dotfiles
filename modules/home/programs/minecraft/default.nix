{ config
, lib
, pkgs
, ...
}:

let
  cfg = config.programs.minecraft;
  inherit (cfg) enable;

  icon = "${pkgs.minecraft.overrideAttrs(_: _: { meta.broken = false; })}/share/icons/hicolor/symbolic/apps/minecraft-launcher.svg";
in
{
  options = {
    programs.minecraft.enable = lib.mkEnableOption "Minecraft";
  };

  config = lib.mkIf enable {
    home.packages = [
      (pkgs.symlinkJoin {
        name = "minecraft";
        paths = [ pkgs.prismlauncher ];
        postBuild = ''
          install -v ${pkgs.prismlauncher}/share/applications/org.prismlauncher.PrismLauncher.desktop $out/share/applications/org.prismlauncher.PrismLauncher.desktop
          substituteInPlace $out/share/applications/org.prismlauncher.PrismLauncher.desktop \
            --replace "Name=Prism Launcher" "Name=Minecraft" \
            --replace "Icon=org.prismlauncher.PrismLauncher" "Icon=${icon}"
        '';
      })
    ];
  };
}
