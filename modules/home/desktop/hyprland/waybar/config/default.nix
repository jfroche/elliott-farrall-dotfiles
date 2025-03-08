{ config
, lib
, pkgs
, ...
}:

let
  cfg = config.desktop.hyprland;
  inherit (cfg) enable;

  inherit (config.stylix) fonts;
  inherit (config.lib.stylix) colors;

  inherit (config) catppuccin;
  accent = colors.withHashtag.${catppuccin.accentBase16};
  text = colors.withHashtag.base05;
  surface2 = colors.withHashtag.base04;

  get-song = pkgs.writeShellScript "current_song" ''
    PLAYER_STATUS=$(${pkgs.playerctl}/bin/playerctl -s status 2> /dev/null | tail -n1)
    ARTIST=$(${pkgs.playerctl}/bin/playerctl metadata artist 2> /dev/null | sed 's/&/+/g')
    TITLE=$(${pkgs.playerctl}/bin/playerctl metadata title 2> /dev/null | sed 's/&/+/g')

    if [[ $PLAYER_STATUS == "Paused" || $PLAYER_STATUS == "Playing" ]]; then
      echo "$ARTIST - $TITLE"
    else
      echo ""
    fi
  '';
  media-exec = pkgs.writeShellScript "media-exec" ''
    ${pkgs.zscroll}/bin/zscroll \
      --delay 0.15 \
      --length 30 \
      --match-command "${pkgs.playerctl}/bin/playerctl status" \
      --scroll-padding " | " \
      --match-text "Paused" "--before-text ' 󰏤 ' --scroll 0" \
      --match-text "Playing" "--before-text ' 󰐊 ' --scroll 1" \
      --match-text "^$" "" \
      --update-check true \
      ${get-song} &
    wait
  '';
in
{
  config = lib.mkIf enable {
    programs.waybar.settings.mainBar = {
      mode = "dock";
      layer = "top";

      margin-top = 5;
      margin-left = 10;
      margin-right = 10;

      modules-left = [ "hyprland/workspaces" "custom/media" ];
      modules-center = [ "clock" ];
      modules-right = [ "group/system" "group/status" "group/menu" ];

      "group/menu" = {
        orientation = "inherit";
        modules = [
          "group/logout"
          "systemd-failed-units"
          "custom/notification"
        ];
      };

      "custom/notification" = {
        tooltip = false;
        format = "{icon}";
        format-icons = {
          "none" = "󰂜";
          "dnd-none" = "󰪑";
          "inhibited-none" = "󰪑";
          "dnd-inhibited-none" = "󰪑";

          "notification" = "󰂚";
          "dnd-notification" = "󰂛";
          "inhibited-notification" = "󰂛";
          "dnd-inhibited-notification" = "󰂛";
        };
        exec-if = "which ${pkgs.swaynotificationcenter}/bin/swaync-client";
        exec = "${pkgs.swaynotificationcenter}/bin/swaync-client -swb";
        on-click = "${pkgs.swaynotificationcenter}/bin/swaync-client -t -sw";
        on-click-right = "${pkgs.swaynotificationcenter}/bin/swaync-client -d -sw";
        return-type = "json";
        escape = true;
      };

      "systemd-failed-units" = {
        format = "󰒏 {nr_failed}";
        on-click = "${config.home.sessionVariables.TERMINAL} sh -c ${pkgs.writeShellScript "status" ''
          trap ' ' INT TERM EXIT
          watch -t '\
            echo "System Units"; \
            systemctl --system --failed --output json | ${pkgs.jtbl}/bin/jtbl -t; \
            echo "User Units"; \
            systemctl --user   --failed --output json | ${pkgs.jtbl}/bin/jtbl -t \
          '
        ''}";
        on-click-right = "${pkgs.writeShellScript "restart" ''
          systemctl --system --failed --output json | ${pkgs.jq}/bin/jq -r '.[].unit' | ${pkgs.findutils}/bin/xargs -r systemctl --system restart
          systemctl --user   --failed --output json | ${pkgs.jq}/bin/jq -r '.[].unit' | ${pkgs.findutils}/bin/xargs -r systemctl --user restart
        ''}";
      };

      "group/logout" = {
        orientation = "inherit";
        modules = [
          "custom/logout"
          "idle_inhibitor"
        ];
        drawer = {
          "transition-left-to-right" = false;
        };
      };

      "custom/logout" = {
        format = "󰍃";
        exec = ''
          printf '{"tooltip": "Logout"}'
        '';
        return-type = "json";
        on-click = "${pkgs.wlogout}/bin/wlogout -n";
      };

      "idle_inhibitor" = {
        format = "{icon}";
        format-icons = {
          "activated" = "󰷛";
          "deactivated" = "󰍹";
        };
        tooltip-format-activated = "Idle Inhibitor (Activated)";
        tooltip-format-deactivated = "Idle Inhibitor (Deactivated)";
      };

      "group/status" = {
        orientation = "inherit";
        modules = [
          "backlight#status"
          "pulseaudio#status"
          "bluetooth#status"
          "network#status"
          "battery#status"
        ];
      };

      "battery#status" = {
        format = "{icon}";
        format-icons = {
          "default" = [ "󱃍" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
          "charging" = [ "󰢟" "󰢜" "󰂆" "󰂇" "󰂈" "󰢝" "󰂉" "󰢞" "󰂊" "󰂋" "󰂅" ];
          "plugged" = "󰚥";
        };
        states = {
          "warning" = 30;
          "critical" = 10;
        };
        tooltip-format-discharging = "Battery ({capacity}%)";
        tooltip-format-charging = "Charging ({capacity}%)";
        tooltip-format-not-charging = "Not Charging ({capacity}%)";
        tooltip-format-plugged = "Plugged In ({capacity}%)";
        on-click = "${config.programs.rofi.finalPackage}/bin/rofi -show power-menu -modi 'power-menu:rofi-power-menu --choices=lockscreen/logout/reboot/shutdown'";
      };

      "network#status" = {
        format = "{icon}";
        format-icons = {
          "default" = "󰤫";
          "disconnected" = "󰤮";
          "wifi" = [ "󰤯" "󰤟" "󰤢" "󰤥" "󰤨" ];
          "ethernet" = "󰌗";
        };
        tooltip-format-disconnected = "Disconnected";
        tooltip-format-wifi = "{essid} ({signalStrength}%)";
        tooltip-format-ethernet = "{essid} (Ethernet)";
        on-click = "${pkgs.internal.rofi-wifi-menu}/bin/rofi-wifi-menu";
      };

      "bluetooth#status" = {
        format = "{icon}";
        format-icons = {
          "disabled" = "󰀦";
          "connected" = "󰂰";
          "on" = "󰂯";
          "off" = "󰂲";
        };
        tooltip-format-disabled = "Bluetooth (Disabled)";
        tooltip-format-connected = "{device_alias} ({device_battery_percentage}%)";
        tooltip-format-on = "Bluetooth (On)";
        tooltip-format-off = "Bluetooth (Off)";
        on-click = "${pkgs.rofi-bluetooth}/bin/rofi-bluetooth";
      };

      "pulseaudio#status" = {
        format = "{icon}";
        format-bluetooth = "{icon}<sup></sup>";
        format-muted = "󰝟";
        format-icons = {
          "default" = [ "󰕿" "󰖀" "󰕾" ];
          "headphone" = "󰋋";
          "hifi" = "󰓃";
          "hdmi" = "󰽟";
          "hands-free" = "󰋎";
          "headset" = "󰋎";
          "phone" = "";
          "portable" = "󰐺";
          "car" = "󰄋";
        };
        tooltip-format = "{desc} ({volume}%)";
        on-click = "${pkgs.internal.rofi-mixer}/bin/rofi-mixer";
      };

      "backlight#status" = {
        format = "{icon}";
        format-icons = [ "󰃚" "󰃛" "󰃜" "󰃝" "󰃞" "󰃟" "󰃠" ];
        tooltip-format = "Brightness ({percent}%)";
        device = "intel_backlight";
      };

      "group/system" = {
        orientation = "inherit";
        modules = [
          "custom/button#system"
          "temperature#system"
          "cpu#system"
          "memory#system"
          "disk#system"
          "network#system"
        ];
        drawer = {
          "transition-left-to-right" = false;
        };
      };

      "custom/button#system" = {
        format = "󰄨";
        tooltip = false;
      };

      "temperature#system" = {
        thermal-zone = 1;
        format = "󰔏 {temperatureC}°C";
        tooltip-format = "Temperature ({temperatureC}°C)";
      };

      "cpu#system" = {
        format = "󰘚 {avg_frequency}GHz";
      };

      "memory#system" = {
        format = "󰍛 {used}GiB";
        tooltip-format = "RAM ({percentage}%)";
      };

      "disk#system" = {
        format = "󱛟 {used}";
        tooltip-format = "Disk ({percentage_used}%)";
      };

      "network#system" = {
        format = "󰛳 {bandwidthUpBits} | {bandwidthDownBits}";
        tooltip-format = "Network (Up: {bandwidthUpBytes} Down: {bandwidthDownBytes})";
      };

      "clock" = {
        format = "{:%H:%M}";
        tooltip-format = "<tt>{calendar}</tt>";
        calendar = {
          format = {
            months = "<span font='${fonts.monospace.name}' color='${text}'><b>{}</b></span>";
            weeks = "<span font='${fonts.monospace.name}' color='${text}'>{}</span>";
            days = "<span font='${fonts.monospace.name}' color='${text}'>{}</span>";
            weekdays = "<span font='${fonts.monospace.name}' color='${surface2}'>{}</span>";
            today = "<span font='${fonts.monospace.name}' color='${accent}'><b>{}</b></span>";
          };
        };
        actions = {
          "on-click" = "shift_down";
          "on-click-right" = "shift_up";
        };
      };

      "custom/media" = {
        on-click = "${pkgs.playerctl}/bin/playerctl play-pause";
        exec = media-exec;
        hide-empty-text = true;
      };

      "hyprland/workspaces" = {
        format = "{icon} | {windows}";
        window-rewrite-default = "󰏗";
      };
    };
  };
}
