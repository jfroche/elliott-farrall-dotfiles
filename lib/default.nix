{ lib
, ...
}:

{

  # Makes systemd unit name for mount
  #
  # path: string          path to mount
  #
  # returns: string       unit name
  mkMountName = path: lib.strings.removePrefix "-" "${builtins.replaceStrings [ "/" ] [ "-" ] path}";

  capitalise = str: "${lib.strings.toUpper (lib.strings.substring 0 1 str)}${lib.strings.substring 1 (builtins.stringLength str - 1) str}";

  globToRegex = with lib.strings; glob:
    concatStrings [ (replaceStrings [ "." "*" ] [ "\\." ".*" ] glob) "$" ];

  mkDefaultApplications = app: mimes: lib.genAttrs mimes (_mime: app);
}
