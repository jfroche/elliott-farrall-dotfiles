{ config
, lib
, ...
}:

let
  cfg = config.browser;
  enable = cfg == "firefox";
in
{
  config = lib.mkIf enable {
    programs.firefox.enable = true;

    home.sessionVariables = {
      BROWSER = "firefox";
    };

    xdg.mimeApps.defaultApplications = {
      "text/html" = "firefox.desktop";
      "application/pdf" = "firefox.desktop";
      "x-scheme-handler/about" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "x-scheme-handler/unknown" = "firefox.desktop";
    } // (builtins.listToAttrs (map (type: { name = "image/${type}"; value = "firefox.desktop"; }) [
      "jpeg"
      "png"
      "svg"
      "gif"
      "webp"
    ])) // (builtins.listToAttrs (map (type: { name = "image/${type}"; value = "firefox.desktop"; }) [
      "mp4"
      "mpeg"
      "webm"
    ]));
  };
}
