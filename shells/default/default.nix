{ pkgs
, inputs
, system
, ...
}:

with pkgs.devshell;

mkShell {
  devshell = {
    startup = {
      pre-commit.text = inputs.self.checks.${system}.pre-commit.shellHook;
      clear = {
        text = "printf '\n%.0s' {1..30}";
        deps = [ "pre-commit" ];
      };
    };

    packages = with pkgs; [
      agenix
    ];
  };
}
