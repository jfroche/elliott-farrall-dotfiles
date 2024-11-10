{ lib
, ...
}:

{
  options = {
    profiles.uos.enable = lib.mkEnableOption "UoS profile";
  };
}
