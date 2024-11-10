{ config
, lib
, pkgs
, ...
}:

let
  cfg = config.programs.mathematica;
  inherit (cfg) enable;
in
{
  options = {
    programs.mathematica.enable = lib.mkEnableOption "Mathematica";
  };

  config = lib.mkIf enable {
    home.packages = [
      (pkgs.symlinkJoin {
        name = "mathematica";
        paths = [ pkgs.mathematica ];
        buildInputs = [ pkgs.makeWrapper ];
        postBuild = ''
          wrapProgram $out/libexec/Mathematica/Executables/Mathematica \
            --set MATHEMATICA_USERBASE ${config.xdg.configHome}/Mathematica
          install -v ${pkgs.mathematica}/share/applications/com.wolfram.Mathematica.14.0.desktop $out/share/applications/com.wolfram.Mathematica.14.0.desktop
          substituteInPlace $out/share/applications/com.wolfram.Mathematica.14.0.desktop \
            --replace "Name=Mathematica 14.0" "Name=Mathematica" \
            --replace "Exec=${pkgs.mathematica}/libexec/Mathematica/Executables/Mathematica --name com.wolfram.Mathematica.14.0 %F" "Exec=$out/libexec/Mathematica/Executables/Mathematica --name com.wolfram.Mathematica.14.0 %F"
        '';
      })
    ];
  };
}
