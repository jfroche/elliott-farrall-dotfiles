{ lib
, pkgs
, config
, ...
}:

let
  cfg = config.programs.libreoffice;
  inherit (cfg) enable;

  package = pkgs.symlinkJoin {
    name = "libreoffice";
    paths = [ pkgs.libreoffice-qt-still ];
    postBuild = ''
      install -v ${pkgs.libreoffice-qt-still}/share/applications/base.desktop $out/share/applications/base.desktop
      rm $out/share/applications/base.desktop
      install -v ${pkgs.libreoffice-qt-still}/share/applications/calc.desktop $out/share/applications/calc.desktop
      rm $out/share/applications/calc.desktop
      install -v ${pkgs.libreoffice-qt-still}/share/applications/draw.desktop $out/share/applications/draw.desktop
      rm $out/share/applications/draw.desktop
      install -v ${pkgs.libreoffice-qt-still}/share/applications/impress.desktop $out/share/applications/impress.desktop
      rm $out/share/applications/impress.desktop
      install -v ${pkgs.libreoffice-qt-still}/share/applications/math.desktop $out/share/applications/math.desktop
      rm $out/share/applications/math.desktop
      install -v ${pkgs.libreoffice-qt-still}/share/applications/writer.desktop $out/share/applications/writer.desktop
      rm $out/share/applications/writer.desktop
      install -v ${pkgs.libreoffice-qt-still}/share/applications/xsltfilter.desktop $out/share/applications/xsltfilter.desktop
      rm $out/share/applications/xsltfilter.desktop
    '';
  };
in
{
  options = {
    programs.libreoffice.enable = lib.mkEnableOption "LibreOffice";
  };

  config = lib.mkIf enable {
    home.packages = [ package ];
  };
}
