{ config
, pkgs
, ...
}:

{
  age.secrets = {
    deploy = {
      file = ./deploy.age;
      owner = "github-runner";
      group = "github-runner";
    };
    dotfiles = {
      file = ./repos/dotfiles.age;
    };
  };

  services.github-nix-ci = {
    personalRunners."elliott-farrall/dotfiles" = {
      tokenFile = config.age.secrets.dotfiles.path;
      num = 5;
    };
    runnerSettings.extraPackages = with pkgs; [
      openssh
      openssl
      gh
    ];
  };
}
