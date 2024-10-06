{ host
, ...
}:

{
  age.secrets.cachix = {
    file = ./token-${host}.age;
    substitutions = [ "/etc/cachix-agent.token" ];
  };

  environment.etc."cachix-agent.token".text = ''
    CACHIX_AGENT_TOKEN=@cachix@
  '';

  services.cachix-agent.enable = true;
}
