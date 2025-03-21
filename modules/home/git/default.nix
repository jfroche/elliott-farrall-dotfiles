{ config
, ...
}:

{
  age.secrets = {
    "github/auth".file = ./auth.age;
    "github/sign".file = ./sign.age;
  };

  programs.git = {
    enable = true;
    userName = "elliott-farrall";
    userEmail = "108588212+elliott-farrall@users.noreply.github.com";
  };

  programs.gh = {
    enable = true;
  };

  programs.ssh.matchBlocks."github.com".identityFile = config.age.secrets."github/auth".path;
}
