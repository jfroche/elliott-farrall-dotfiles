{ lib
, ...
}:

{
  services.kmscon.enable = lib.mkForce false;
}
