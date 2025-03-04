{ system ? builtins.currentSystem }:
let
  nixpkgsSrc = builtins.fetchTarball "https://github.com/NixOS/nixpkgs/archive/refs/heads/nixos-unstable.tar.gz";
  treefmt-nixSrc = builtins.fetchTarball "https://github.com/numtide/treefmt-nix/archive/refs/heads/master.tar.gz";
  nixpkgs = import nixpkgsSrc { inherit system; };
  treefmt-nix = import treefmt-nixSrc;
in
treefmt-nix.mkWrapper nixpkgs ../checks/pre-commit/treefmt.nix
