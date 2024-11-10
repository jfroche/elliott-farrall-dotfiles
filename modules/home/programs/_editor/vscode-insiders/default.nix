{ config
, lib
, pkgs
, ...
}:

let
  cfg = config.editor;
  enable = cfg == "vscode-insiders";
in
{
  config = lib.mkIf enable {
    programs.vscode = {
      enable = true;
      package = pkgs.vscode-insiders.overrideAttrs (attrs: {
        desktopItems = [
          ((lib.lists.findFirst (item: item.name == "code-insiders.desktop") null attrs.desktopItems).override {
            desktopName = "VS Code";
          })
          ((lib.lists.findFirst (item: item.name == "code-insiders-url-handler.desktop") null attrs.desktopItems).override {
            desktopName = "VS Code URL Handler";
          })
        ];
      });
    };

    home.sessionVariables = {
      EDITOR = "code-insiders -w";
      VISUAL = "code-insiders -w";
    };

    home.shellAliases = {
      code-compat = "ELECTRON_OZONE_PLATFORM_HINT= code-insiders";
    };

    xdg.mimeApps.defaultApplications = (builtins.listToAttrs (map (type: { name = type; value = "code-insiders.desktop"; }) [
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
    ])) // {
      "application/x-desktop" = "code-insiders-url-handler.desktop";
    };
  };
}
