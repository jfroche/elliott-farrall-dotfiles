{ mkShell
, inputs
, pkgs
, ...
}:

mkShell {
  name = "dotfiles";

  inherit (inputs.self.checks.x86_64-linux.pre-commit) shellHook;
  buildInputs = inputs.self.checks.x86_64-linux.pre-commit.enabledPackages;

  packages = with pkgs; [
    snowfallorg.flake
    nix-inspect
    nix-melt
    fup-repl
    agenix

    nix-init

    xdg-ninja
  ];
}
