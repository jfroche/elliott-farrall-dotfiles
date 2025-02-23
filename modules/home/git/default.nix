{ config
, ...
}:

{
  age.secrets."github/auth".file = ./auth.age;

  programs.git = {
    enable = true;
    userName = "ElliottSullingeFarrall";
    userEmail = "elliott.chalford@gmail.com";
  };

  programs.gh = {
    enable = true;
  };

  programs.ssh.matchBlocks."github.com".identityFile = config.age.secrets."github/auth".path;
}
