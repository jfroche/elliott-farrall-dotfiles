{ lib
, config
, ...
}:

lib.mkIf (config.locale == "uk") {
  services.xserver.xkb.layout = "gb";
  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";
}
