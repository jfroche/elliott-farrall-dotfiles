{ config
, pkgs
, ...
}:

{
  age.secrets = {
    dotfiles = {
      file = ./dotfiles.age;
    };
    key-deploy = {
      file = ./key.age;
      owner = "github-runner";
      group = "github-runner";
    };
  };

  services.github-nix-ci = {
    personalRunners."ElliottSullingeFarrall/dotfiles" = {
      tokenFile = config.age.secrets.dotfiles.path;
      num = 6;
    };
    runnerSettings.extraPackages = with pkgs; [
      openssh
      openssl
      gh
    ];
  };
}
