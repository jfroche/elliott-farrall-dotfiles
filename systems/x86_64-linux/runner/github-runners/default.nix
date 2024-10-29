{ config
, ...
}:

{
  age.secrets.github-runner-token.file = ./token.age;

  services.github-runners.nixos = {
    enable = true;
    url = "https://github.com/ElliottSullingeFarrall/dotfiles";
    tokenFile = config.age.secrets.github-runner-token.path;
    user = "root";
    replace = true;
  };
}
