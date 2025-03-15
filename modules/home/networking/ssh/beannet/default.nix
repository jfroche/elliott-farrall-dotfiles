{ config
, lib
, ...
}:

{
  age.secrets = {
    "users/root/key" = {
      file = ./root.age;
      path = "${config.home.homeDirectory}/.ssh/keys/root";
    };
    "users/elliott/key" = {
      file = ./elliott.age;
      path = "${config.home.homeDirectory}/.ssh/keys/elliott";
    };
  };

  programs.ssh.matchBlocks = lib.mkMerge [
    (lib.internal.mkMatchBlock {
      hostname = "broad";
      user = "root";
      identityFile = config.age.secrets."users/root/key".path;
      port = 2222;
      extraOptions = {
        StrictHostKeyChecking = "no";
        UserKnownHostsFile = "/dev/null";
      };
    })
    (lib.internal.mkMatchBlock {
      hostname = "broad";
      user = "elliott";
      identityFile = config.age.secrets."users/elliott/key".path;
      port = 2222;
      extraOptions = {
        StrictHostKeyChecking = "no";
        UserKnownHostsFile = "/dev/null";
      };
    })
    (lib.internal.mkMatchBlock { hostname = "lima"; user = "root"; identityFile = config.age.secrets."users/root/key".path; })
    (lib.internal.mkMatchBlock { hostname = "lima"; user = "elliott"; identityFile = config.age.secrets."users/elliott/key".path; })
  ];
}
