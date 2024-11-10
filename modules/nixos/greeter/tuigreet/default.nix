{ config
, lib
, pkgs
, ...
}:

let
  cfg = config.greeter;
  enable = cfg == "tuigreet";

  inherit (config.services.displayManager.sessionData) desktops;

  # disable-external-displays = pkgs.writeShellScript "disable-external-displays" ''
  #   #!/bin/bash
  #   ${lib.getExe pkgs.parallel} "${lib.getExe pkgs.ddcutil} setvcp D6 05 --bus {}" ::: {18..19}
  # '';

  # enable-external-displays = pkgs.writeShellScript "enable-external-displays" ''
  #   #!/bin/bash
  #   ${lib.getExe pkgs.parallel} "${lib.getExe pkgs.ddcutil} setvcp D6 01 --bus {}" ::: {18..19}
  # '';
in
{
  imports = [
    ./logs_fix.nix
  ];

  config = lib.mkIf enable {
    services.greetd.settings.default_session.command = "${lib.getExe pkgs.greetd.tuigreet} --remember --remember-session --user-menu --session-wrapper '${pkgs.execline}/bin/exec > /dev/null' --sessions ${desktops}/share/wayland-sessions --xsessions ${desktops}/share/xsessions";

    # Early KMS
    boot.initrd.kernelModules = [ "i915" ];

    services.ddccontrol.enable = true;

    # hardware.display = {
    #   edid.modelines = {
    #     "FHD" = "  173.00  1920 2048 2248 2576  1080 1083 1088 1120 -hsync +vsync";
    #   };
    #   outputs = {
    #     "eDP-1".edid = "FHD.bin";
    #   };
    # };



    # boot.kernelParams = [
    #   "video=DP-1:1024x768"
    #   "video=DP-2:1024x768"
    #   "video=DP-3:1024x768"
    #   "video=DP-4:1024x768"
    #   "video=DP-5:1024x768"
    #   "video=DP-6:1024x768"
    #   "video=DP-7:1024x768"
    # ];

    # boot.kernelModules = [ "i2c-dev" ];

    # systemd.services.disable-external-displays = {
    #   description = "Disable external displays during login";
    #   after = [ "greetd.service" ];
    #   wantedBy = [ "greetd.service" ];
    #   serviceConfig = {
    #     ExecStart = disable-external-displays;
    #     Type = "oneshot";
    #   };
    # };

    # systemd.services.enable-external-displays = {
    #   description = "Enable external displays after login";
    #   after = [ "graphical.target" ];
    #   wantedBy = [ "graphical.target" ];
    #   serviceConfig = {
    #     ExecStart = enable-external-displays;
    #     Type = "oneshot";
    #   };
    # };
  };
}
