{ pkgs
, ...
}:

{
  services.printing.package = pkgs.symlinkJoin {
    name = "cups";
    paths = [ pkgs.cups ];
    postBuild = ''
      install -v ${pkgs.cups}/share/applications/cups.desktop $out/share/applications/cups.desktop
      rm $out/share/applications/cups.desktop
    '';
  };
}
