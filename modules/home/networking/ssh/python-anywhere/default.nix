{ config
, ...
}:

{
  age.secrets."python-anywhere/key".file = ./key.age;

  programs.ssh.matchBlocks."ssh.eu.pythonanywhere.com" = {
    user = "ElliottSF";
    identityFile = config.age.secrets."python-anywhere/key".path;
  };
}
