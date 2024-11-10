{ config
, lib
, ...
}:

let
  cfg = config.programs.mathematica;
  inherit (cfg) enable;
in
{
  config = lib.mkIf enable {
    xdg.configFile."Mathematica/Kernel/init.m" = {
      text = ''
        With[{dir = $UserDocumentsDirectory <> "/Wolfram Mathematica"},
          If[DirectoryQ[dir], DeleteDirectory[dir]]
        ]
      '';
      force = true;
    };

    xdg.configFile."Mathematica/FrontEnd/init.m" = {
      text = ''
        SetOptions[$FrontEnd,
          VersionsLaunched->{"14.0.0"},

          NotebookBrowseDirectory -> "${config.xdg.configHome}/Mathematica/SystemFiles/FrontEnd/StyleSheets",
          DefaultStyleDefinitions -> "${config.xdg.configHome}/Mathematica/SystemFiles/FrontEnd/StyleSheets/Catppuccin.nb",

          WindowToolbars -> {},
          ShowPredictiveInterface -> False,

          NotebookAutoSave -> True,
          ClosingAutoSave -> True,

          PrivateFrontEndOptions -> {ShowAtStartup -> NewDocument},
          PrivateNotebookOptions -> {FinalWindowPrompt -> False}
        ]
      '';
      force = true;
    };

    home.activation = {
      linkWolfram = lib.internal.mkLinkScript "${config.xdg.configHome}/Wolfram" "${config.home.homeDirectory}/.Wolfram";
    };
  };
}
