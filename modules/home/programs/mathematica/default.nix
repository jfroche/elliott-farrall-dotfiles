{ lib
, pkgs
, config
, ...
}:

let
  cfg = config.programs.mathematica;
  inherit (cfg) enable;

  package = pkgs.symlinkJoin {
    name = "mathematica";
    paths = [ pkgs.mathematica ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      install -v ${pkgs.mathematica}/share/applications/com.wolfram.Mathematica.14.0.desktop $out/share/applications/com.wolfram.Mathematica.14.0.desktop
      substituteInPlace $out/share/applications/com.wolfram.Mathematica.14.0.desktop \
        --replace "Name=Mathematica 14.0" "Name=Mathematica" \
        --replace "Exec=${pkgs.mathematica}/libexec/Mathematica/Executables/Mathematica --name com.wolfram.Mathematica.14.0 %F" "Exec=$out/libexec/Mathematica/Executables/Mathematica --name com.wolfram.Mathematica.14.0 %F"
    '';
  };
in
{
  options = {
    programs.mathematica.enable = lib.mkEnableOption "Mathematica";
  };

  config = lib.mkIf enable {
    home.packages = [ package ];
  };
}
