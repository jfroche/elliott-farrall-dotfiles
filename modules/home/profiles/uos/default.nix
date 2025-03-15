{ lib
, osConfig ? null
, ...
}:

{
  options = {
    profiles.uos.enable = lib.mkEnableOption "UoS profile" // {
      default = osConfig.profiles.uos.enable or false;
    };
  };
}
