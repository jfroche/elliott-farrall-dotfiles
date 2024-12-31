{ config
, lib
, pkgs
, ...
}:

let
  cfg = config.tools.ansible;
  inherit (cfg) enable;
in
{
  options = {
    tools.ansible.enable = lib.mkEnableOption "Ansible";
  };

  config = lib.mkIf enable {
    environment.systemPackages = with pkgs; [
      (pkgs.symlinkJoin {
        name = "ansible";
        paths = [ ansible];
        buildInputs = [ python3 makeWrapper ];
        postBuild = ''
          for f in $out/bin/ansible*; do
            wrapProgram $f --set ANSIBLE_HOME \$XDG_CONFIG_HOME/ansible
          done
        '';
      })
      # python3
    ];

    environment.etc."ansible/hosts".text = ''
      [linux]
      broad
      lima

    '';

    environment.sessionVariables = {
      ANSIBLE_HOME = "$HOME/.config/ansible";
    };

    # environment.variables = {
    #   PYTHONWARNINGS = "ignore::UserWarning"; # https://github.com/ansible/ansible/issues/52598
    # };
  };
}
