{ lib
, osConfig ? null
, ...
}:

{
  imports = [
    ./_addons/starship.nix
  ];

  options = {
    shell = lib.mkOption {
      description = "The shell to use.";
      type = lib.types.enum [
        "bash"
        "zsh"
      ];
      default = osConfig.shell or "bash";
    };
  };
}
