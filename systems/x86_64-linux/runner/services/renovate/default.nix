{ config
, pkgs
, ...
}:

{
  age.secrets."renovate/token".file = ./token.age;

  services.renovate = {
    enable = true;
    credentials.RENOVATE_TOKEN = config.age.secrets."renovate/token".path;

    runtimePackages = with pkgs; [ nix ];

    settings = {
      autodiscover = true;
      onboarding = false;
      allowedCommands = [ ".*" ];
    };
  };
}
