{ inputs
, ...
}:

_final: prev:
{
  inherit (inputs.kmscon.legacyPackages.${prev.system}) kmscon;
}
