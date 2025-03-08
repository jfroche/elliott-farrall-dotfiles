{ osConfig ? null
, lib
, ...
}:

{
  options = {
    profiles.uos.enable = lib.mkEnableOption "UoS profile" // {
      enable = osConfig.profiles.uos.enable or false;
    };
  };
}
