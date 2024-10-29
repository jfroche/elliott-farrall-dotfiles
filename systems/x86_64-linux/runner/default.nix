{ ...
}:

{
  imports = [
    ./github-runners
  ];

  age.identityPaths = [
    "/var/garnix/keys/repo-key"
  ];

  services.tailscale.authKeyParameters = {
    ephemeral = true;
    preauthorized = true;
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
