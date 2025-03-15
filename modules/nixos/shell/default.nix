{ lib
, pkgs
, config
, ...
}:

let
  cfg = config.shell;

  shells = [ "zsh" ];
in
{
  imports = [
    ./_addons/starship.nix
    # ./_addons/tty.nix
  ];

  options = {
    shell = lib.mkOption {
      type = lib.types.enum (shells ++ [ "bash" ]);
      default = "bash";
      description = "The shell to use.";
    };
  };

  config = lib.mkIf (cfg != "bash") {
    users.defaultUserShell = pkgs.${cfg};
  };
}
