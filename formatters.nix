{
  projectRootFile = "flake.nix";

  settings.global.excludes = [
    "LICENSE.md"
    ".editorconfig"
    "*.env"
    "*.ini"
    "*.conf"
    "*.age"
    "*.hash"
    "*.ppd"
    "*.jpg"
  ];

  programs = {
    prettier.enable = true;

    # Nix
    nixpkgs-fmt.enable = true;
    deadnix.enable = true;
    statix = {
      enable = true;
      disabled-lints = [ "empty_pattern" "repeated_keys" ];
    };

    # Configs
    jsonfmt.enable = true;
    taplo.enable = true;
    yamlfmt.enable = true;
    actionlint.enable = true;

    # Scripts
    shfmt.enable = true;
    beautysh.enable = true;
  };

  settings.formatter = {
    yamlfmt.options = [ "-formatter" "retain_line_breaks_single=true" ];
    actionlint.options = [ "-ignore" "label \".+\" is unknown" ];

    nixpkgs-fmt.excludes = [ "modules/nixos/boot/silent/boot/*" ];
    deadnix.excludes = [ "modules/nixos/boot/silent/boot/*" ];
    statix.excludes = [ "modules/nixos/boot/silent/boot/*" ];
    taplo.excludes = [ "templates/**/*" ];
    shfmt.excludes = [ "modules/nixos/boot/silent/boot/*" ];
    beautysh.excludes = [ "modules/nixos/boot/silent/boot/*" ];
  };
}
