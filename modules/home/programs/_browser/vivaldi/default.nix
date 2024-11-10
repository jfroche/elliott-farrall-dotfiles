{ config
, lib
, pkgs
, ...
}:

let
  cfg = config.browser;
  enable = cfg == "vivaldi";
in
{
  config = lib.mkIf enable {
    home.packages = [
      (pkgs.vivaldi.overrideAttrs (attrs: {
        postInstall = (attrs.postInstall or "") + ''
          wrapProgram $out/bin/vivaldi \
            --add-flags "\''${WAYLAND_DISPLAY:+--ozone-platform=wayland}"
        '';
      }))
    ];

    home.sessionVariables = {
      BROWSER = "vivaldi-stable";
    };

    xdg.mimeApps.defaultApplications = {
      "text/html" = "vivaldi-stable.desktop";
      "application/pdf" = "vivaldi-stable.desktop";
      "x-scheme-handler/about" = "vivaldi-stable.desktop";
      "x-scheme-handler/http" = "vivaldi-stable.desktop";
      "x-scheme-handler/https" = "vivaldi-stable.desktop";
      "x-scheme-handler/unknown" = "vivaldi-stable.desktop";
    } // (builtins.listToAttrs (map (type: { name = "image/${type}"; value = "vivaldi-stable.desktop"; }) [
      "jpeg"
      "png"
      "svg"
      "gif"
      "webp"
    ])) // (builtins.listToAttrs (map (type: { name = "image/${type}"; value = "vivaldi-stable.desktop"; }) [
      "mp4"
      "mpeg"
      "webm"
    ]));
  };
}
