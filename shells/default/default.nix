{ mkShell
, pkgs
, inputs
, system
, ...
}:

mkShell {
  name = "dotfiles";

  inherit (inputs.self.checks.${system}.pre-commit) shellHook;
  buildInputs = inputs.self.checks.${system}.pre-commit.enabledPackages;

  packages = with pkgs; [
    agenix
  ];
}
