{ lib
, ...
}:

{
  imports = [
    ./github-runners
  ];

  age.identityPaths = [
    "/var/garnix/keys/repo-key"
  ];

  age.secrets.tailscale.file = lib.mkForce ./tailscale.age;

  /* --------------------------------- Version -------------------------------- */

  version = {
    linux = "latest";
    nix = "latest";
    nixos = "24.11";
  };

  /* --------------------------------- Locale --------------------------------- */

  locale = "uk";

}
