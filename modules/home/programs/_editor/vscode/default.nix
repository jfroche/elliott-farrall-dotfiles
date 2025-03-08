{ config
, lib
, pkgs
, ...
}:

let
  cfg = config.editor;
  enable = (cfg == "vscode") || (cfg == "vscode-insiders");

  name = if cfg == "vscode" then "code" else "code-insiders";

  inherit (lib.internal) mkDefaultApplications;

  package = pkgs.${cfg}.overrideAttrs (attrs: {
    desktopItems = [
      ((lib.lists.findFirst (item: item.name == "${name}.desktop") null attrs.desktopItems).override {
        desktopName = "VS Code";
      })
      ((lib.lists.findFirst (item: item.name == "${name}-url-handler.desktop") null attrs.desktopItems).override {
        desktopName = "VS Code URL Handler";
      })
    ];
    postInstall =
      if config.wayland.windowManager.hyprland.enable then ''
        wrapProgram $out/bin/${name} \
          --set ELECTRON_OZONE_PLATFORM_HINT auto
      '' else null;
  });
in
{
  config = lib.mkIf enable {
    programs.vscode = {
      enable = true;
      inherit package;
    };

    home.shellAliases = lib.mkIf (cfg == "vscode-insiders") {
      code = "code-insiders";
    };

    home.sessionVariables = {
      EDITOR = "${name} -w";
      VISUAL = "${name} -w";
    };

    xdg.mimeApps.defaultApplications = mkDefaultApplications "${name}.desktop" [
      "text/plain"
      "text/html"
      "text/css"
      "text/javascript"
      "application/javascript"
      "application/json"
      "application/xml"
      "application/x-yaml"
      "application/x-python"
      "application/x-php"
      "application/x-ruby"
      "application/x-perl"
      "application/x-shellscript"
      "application/x-csrc"
      "application/x-c++src"
      "application/x-java"
      "application/sql"
    ] // {
      "application/x-desktop" = "${name}-url-handler.desktop";
    };
  };
}
