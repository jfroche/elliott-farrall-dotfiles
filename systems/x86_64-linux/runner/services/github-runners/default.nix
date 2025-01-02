{ config
, pkgs
, ...
}:

{
  age.secrets = {
    root = {
      file = ./root.age;
      owner = "github-runner";
      group = "github-runner";
    };
    dotfiles = {
      file = ./repos/dotfiles.age;
    };
  };

  system.activationScripts.setupAuthorizedKeys = ''
    cat /etc/ssh/authorized_keys.d/root >> /root/.ssh/authorized_keys
  '';

  services.github-nix-ci = {
    personalRunners."elliott-farrall/dotfiles" = {
      tokenFile = config.age.secrets.dotfiles.path;
      num = 1;
    };
    runnerSettings.extraPackages = with pkgs; [
      openssh
      openssl
      gh
    ];
  };
}
