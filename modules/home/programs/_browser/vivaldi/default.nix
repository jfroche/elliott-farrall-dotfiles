{ lib
, pkgs
, config
, ...
}:

let
  cfg = config.browser;
  enable = cfg == "vivaldi";

  inherit (lib.internal) mkDefaultApplications;

  package = pkgs.vivaldi.overrideAttrs (attrs: {
    postInstall = (attrs.postInstall or "") + ''
      wrapProgram $out/bin/vivaldi \
        --add-flags "\''${WAYLAND_DISPLAY:+--ozone-platform=wayland}"
    '';
  });
in
{
  config = lib.mkIf enable {
    home.packages = [ package ];

    home.sessionVariables.BROWSER = "vivaldi-stable";

    xdg.mimeApps.defaultApplications = mkDefaultApplications "vivaldi-stable.desktop" [
      "text/html"
      "application/pdf"
      "x-scheme-handler/about"
      "x-scheme-handler/http"
      "x-scheme-handler/https"
      "x-scheme-handler/unknown"
      "image/jpeg"
      "image/png"
      "image/svg"
      "image/gif"
      "image/webp"
      "image/mp4"
      "image/mpeg"
      "image/webm"
    ];
  };
}
