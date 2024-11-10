{ config
, lib
, ...
}:

let
  cfg = config.programs.libreoffice;
  inherit (cfg) enable;
in
{
  config = lib.mkIf enable {
    xdg.configFile."libreoffice/4/user/registrymodifications.xcu" = {
      text = ''
        <?xml version="1.0" encoding="UTF-8"?>
        <oor:items xmlns:oor="http://openoffice.org/2001/registry" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">

        <item oor:path="/org.openoffice.Office.Common/Misc"><prop oor:name="FirstRun" oor:op="fuse"><value>false</value></prop></item>
        <item oor:path="/org.openoffice.Office.Common/Misc"><prop oor:name="ShowTipOfTheDay" oor:op="fuse"><value>false</value></prop></item>

        <item oor:path="/org.openoffice.Office.UI.ToolbarMode"><prop oor:name="ActiveCalc" oor:op="fuse"><value>notebookbar.ui</value></prop></item>
        <item oor:path="/org.openoffice.Office.UI.ToolbarMode"><prop oor:name="ActiveDraw" oor:op="fuse"><value>notebookbar.ui</value></prop></item>
        <item oor:path="/org.openoffice.Office.UI.ToolbarMode"><prop oor:name="ActiveImpress" oor:op="fuse"><value>notebookbar.ui</value></prop></item>
        <item oor:path="/org.openoffice.Office.UI.ToolbarMode"><prop oor:name="ActiveWriter" oor:op="fuse"><value>notebookbar.ui</value></prop></item>
        <item oor:path="/org.openoffice.Office.UI.ToolbarMode/Applications/org.openoffice.Office.UI.ToolbarMode:Application['Calc']"><prop oor:name="Active" oor:op="fuse"><value>notebookbar.ui</value></prop></item>
        <item oor:path="/org.openoffice.Office.UI.ToolbarMode/Applications/org.openoffice.Office.UI.ToolbarMode:Application['Draw']"><prop oor:name="Active" oor:op="fuse"><value>notebookbar.ui</value></prop></item>
        <item oor:path="/org.openoffice.Office.UI.ToolbarMode/Applications/org.openoffice.Office.UI.ToolbarMode:Application['Impress']"><prop oor:name="Active" oor:op="fuse"><value>notebookbar.ui</value></prop></item>
        <item oor:path="/org.openoffice.Office.UI.ToolbarMode/Applications/org.openoffice.Office.UI.ToolbarMode:Application['Writer']"><prop oor:name="Active" oor:op="fuse"><value>notebookbar.ui</value></prop></item>

        </oor:items>
      '';
      force = true;
    };
  };
}
