{ osConfig
, lib
, ...
}:

let
  shells = [ "zsh" ];
in
{
  imports = [
    ./_addons/starship.nix
  ];

  options = {
    shell = lib.mkOption {
      type = lib.types.enum (shells ++ [ "bash" ]);
      default = if osConfig != null then osConfig.shell else "bash";
      description = "The shell to use.";
    };
  };
}
