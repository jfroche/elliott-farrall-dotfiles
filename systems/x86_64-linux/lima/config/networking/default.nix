{ config
, ...
}:

{
  age.secrets = {
    network-eduroam.file = ./eduroam.age;
  };

  networking = {
    networkmanager.enable = true;
    firewall.allowedTCPPorts = [ 80 443 8443 ];
    firewall.allowedUDPPorts = [ 5901 ]; # rmview
  };

  environment.etc = {
    "NetworkManager/system-connections/eduroam.nmconnection" = {
      source = config.age.secrets.network-eduroam.path;
      mode = "0600";
    };
  };
}
