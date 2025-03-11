{ lib
, system
, inputs
, ...
}:

lib.pre-commit-hooks.${system}.run {
  src = ./.;

  excludes = [
    ".*\\.age$"
    ".*\\.hash$"
    ".*\\.ppd$"
    ".*hardware\\.nix$"
    "^modules/nixos/boot/silent/boot/[^/]+$"
    "^secrets.nix"
  ];

  hooks = {

    /* --------------------------------- Editor --------------------------------- */

    editorconfig-checker.enable = true;
    end-of-file-fixer.enable = true;
    trim-trailing-whitespace.enable = true;

    /* --------------------------------- Checks --------------------------------- */

    nil.enable = true;
    check-json.enable = true;
    check-toml.enable = true;
    check-yaml.enable = true;

    check-executables-have-shebangs.enable = true;
    check-shebang-scripts-are-executable.enable = true;

    /* --------------------------------- Format --------------------------------- */

    treefmt = {
      enable = true;
      package = inputs.self.formatter.${system};
    };

    /* ----------------------------------- Git ---------------------------------- */

    convco.enable = true;
    check-added-large-files = {
      enable = true;
      excludes = [ "\\wallpaper.jpg" ];
    };
    check-vcs-permalinks.enable = true;
    detect-private-keys.enable = true;
    forbid-new-submodules.enable = true;

  };
}
