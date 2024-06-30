{ lib
, pkgs
, system
, ...
}:

lib.pre-commit-hooks.${system}.run {
  src = ./.;

  hooks = {

    /* --------------------------------- Editor --------------------------------- */

    editorconfig-checker.enable = true;
    end-of-file-fixer.enable = true;
    trim-trailing-whitespace.enable = true;

    # typos = {
    #   enable = true;
    #   settings.configPath = "typos.toml";
    # };

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
      package = lib.treefmt-nix.mkWrapper pkgs ./treefmt.nix;
    };

    /* ----------------------------------- Git ---------------------------------- */

    check-prebuild = {
      enable = true;
      name = "check-prebuild";
      entry = "${pkgs.writeShellScript "check-prebuild" ''
        commit_message=$(git log -1 --pretty=%B)
        if echo "$commit_message" | grep -q '^PREBUILD'; then
          echo "ERROR: Commit message contains 'PREBUILD'. Commit aborted."
          exit 1
        fi
      ''}";
      pass_filenames = false;
      stages = [ "pre-push" ];
    };

    check-added-large-files = {
      enable = true;
      excludes = [ "\\wallpaper.jpg" ];
    };
    check-vcs-permalinks.enable = true;
    detect-private-keys.enable = true;
    forbid-new-submodules.enable = true;

  };

  excludes = [
    ".*\\.age$"
    "^modules/nixos/boot/silent/boot/[^/]+$"
  ];
}
