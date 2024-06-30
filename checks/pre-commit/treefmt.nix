{
  projectRootFile = ".git/config";
  settings.global.excludes = [
    ".editorconfig"
    ".gitattributes"
    "*.env"
    "*.conf"
    "*.ini"
    "*.age"
    "*.jpg"
    "*.md"
    "*.code-workspace"
    "modules/nixos/boot/silent/boot/*"
    "templates/**/*"
  ];
  programs = {
    actionlint.enable = true;
    beautysh.enable = true;
    deadnix.enable = true;
    jsonfmt.enable = true;
    # mdformat.enable = true;
    nixpkgs-fmt.enable = true;
    prettier.enable = true;
    shfmt.enable = true;
    statix = {
      enable = true;
      disabled-lints = [ "empty_pattern" "repeated_keys" ];
    };
    taplo.enable = true;
    yamlfmt.enable = true;
  };
  settings.formatter = {
    yamlfmt.options = [ "-formatter" "retain_line_breaks_single=true" ];
  };
}
