{ config
, pkgs
, ...
}:

let
  inherit (config.catppuccin) flavour accent;
in
{
  imports = [ ../../common/theme.nix ];

  stylix = {
    polarity =
      if (flavour == "frappe") then
        "light"
      else
        "dark";

    iconTheme = {
      enable = true;
      dark = "Papirus-Dark";
      light = "Papirus-Light";
      package = pkgs.catppuccin-papirus-folders.override { flavor = flavour; inherit accent; };
    };

    opacity = {
      applications = 0.9;
      desktop = 0.9;
      popups = 1.0;
      terminal = 0.9;
    };

    targets.vscode.enable = false;
  };
}
