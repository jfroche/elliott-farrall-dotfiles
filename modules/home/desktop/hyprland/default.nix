{ osConfig
, config
, lib
, pkgs
, ...
}:

let
  cfg = config.desktop.hyprland;
  inherit (cfg) enable;
in
{
  options = {
    desktop.hyprland.enable = lib.mkEnableOption "hyprland desktop";
  };

  config = lib.mkIf enable {
    assertions = [
      (lib.mkIf (osConfig != null) {
        assertion = osConfig.services.pipewire.enable;
        message = "Hyprland requires PipeWire to be enabled for screensharing";
      })
      (lib.mkIf (osConfig != null) {
        assertion = osConfig.services.pipewire.wireplumber.enable;
        message = "Hyprland requires WirePlumber to be enabled for screensharing";
      })
    ];

    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [ xdg-desktop-portal-hyprland xdg-desktop-portal-gtk ];
      configPackages = with pkgs; [ hyprland ];
    };
  };
}
