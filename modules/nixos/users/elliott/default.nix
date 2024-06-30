{ config
, lib
, ...
}:

{
  users.users.elliott = {
    isNormalUser = true;

    uid = 1000;
    group = "users";

    hashedPassword = "$6$6Epf31BHWlJgVZ98$KaIYWkSkh.AOv4cgXLAOZsf4RBvWC2fgjDj0N2ifrxPpAqHQxOrSz3WXk80ZyG6Qr6Sd69NKAAWHqiU2O4UUo1"; # https://github.com/NixOS/nixpkgs/issues/99433
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC6ZP8YiM5PTp6ZrgVVdJq8UVifTK8IvEiKN5i1vTnMX"
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC1+DUQegdnmPTIPRG5ohsC5JrMpUqRf3iHh8xaZG5QvrTIZkSq1H6bUK3A7y7WH6z7SrF8Jp4ccQnGm3B3/xQrfZo5Lhiv25pp04TYtDI1MLcN6PaRVJOPMwqWE0M8jdDXyAatgurwi7uNx0JjElPxyRD3bFC6CLmrt5RLqFqHV3/0eYVro3N68+FvywBjn2f50wCMwyLNjmlD3xY2h2z4Tz4/L4r8DgGgTUMSVIODNuBt3y1eSghmxYdLf4Ms9/e+HLLrqfozSH7n5dYK+BVYjAE/b1OakwhgLorr6kyKb4fVLOZXw0Exa0RQED3USXraWY1/jn4EhrkcWQBCQCzSzgOmuO6qW8obJPEtYpH8p5zNnCLymLrxrqPBgTnSannPNTy/uxlHu4BqpdRTM5SoiRdlezKUhGkokV9acotO5kqFd1mVYjYhhdBnuEJfq2vnRoOrF5WqnQWBMwwQldbEdNggVFPExQLccMKpLv/hO/qe9J3jgB1CYYZJQuujZHQ5On/XynexmhWI3u27aXHcF2aA2XdNbCDeG/2WmTm2IXDHBFUbz1rjBxpFK8Ts0olt7scjKf5RFZwPjfdY3CcPVt8/keRXqGvM9zsNs0cfPPHCmYVwl+S0RQYhWSSDZxeK7GG5xDvcmfdTi9pT0Y/yL/UvYB4bA54kdzdfpzYfRQ=="
    ];

    extraGroups = [
      "wheel"
      (lib.mkIf config.networking.networkmanager.enable "networkmanager")
      (lib.mkIf config.virtualisation.docker.enable "docker")
      (lib.mkIf config.virtualisation.podman.enable "podman")
      (lib.mkIf config.hardware.openrazer.enable "openrazer")
    ];
  };
}
