{ config
, ...
}:

{
  imports = [
    ./github-runners
  ];

  age.identityPaths = [
    "/var/garnix/keys/repo-key"
  ];

  environment.variables = {
    XDG_RUNTIME_DIR = "/run/user/${builtins.toString config.users.users.elliott.uid}";
  };

  /* --------------------------------- Version -------------------------------- */

  version = {
    linux = "latest";
    nix = "latest";
    nixos = "24.11";
  };

  /* --------------------------------- Locale --------------------------------- */

  locale = "uk";

}
