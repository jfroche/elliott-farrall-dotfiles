{ config
, lib
, ...
}:

let
  cfg = config.profiles.uos;
  inherit (cfg) enable;
in
{
  config = lib.mkIf enable {
    age.secrets."profiles/uos/key".file = ./key.age;

    programs.ssh.matchBlocks = {
      AccessEPS = {
        hostname = "access.eps.surrey.ac.uk";
        user = "es00569";
        identityFile = config.age.secrets."profiles/uos/key".path;
        forwardX11 = true;
        forwardX11Trusted = true;
      };
      MathsCompute01 = {
        hostname = "maths-compute01";
        user = "es00569";
        identityFile = config.age.secrets."profiles/uos/key".path;
        forwardX11 = true;
        forwardX11Trusted = true;
        proxyJump = "AccessEPS";
      };
    };
  };
}
