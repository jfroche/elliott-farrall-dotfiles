{ config
, pkgs
, system
, ...
}:

{
  age.secrets.dotfiles.file = ./dotfiles.age;

  services.github-nix-ci = {
    personalRunners."ElliottSullingeFarrall/dotfiles" = {
      tokenFile = config.age.secrets.dotfiles.path;
      num = 5;
    };
    runnerSettings.extraPackages = with pkgs; [
      openssh
      openssl
      tailscale
    ];
  };

  nixpkgs.hostPlatform = { inherit system; };
}
