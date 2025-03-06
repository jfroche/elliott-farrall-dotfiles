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
    home.file.".Mathematica/FrontEnd/init.m".text = ''
      SetOptions[$FrontEnd,
        VersionsLaunched->{"14.0.0"},

        DefaultStyleDefinitions -> "${config.home.homeDirectory}/.Mathematica/SystemFiles/FrontEnd/StyleSheets/Catppuccin.nb",

        WindowToolbars -> {},
        ShowPredictiveInterface -> False,

        NotebookAutoSave -> True,
        ClosingAutoSave -> True,

        PrivateFrontEndOptions -> {ShowAtStartup -> NewDocument},
        PrivateNotebookOptions -> {FinalWindowPrompt -> False}
      ]
    '';
  };
}
