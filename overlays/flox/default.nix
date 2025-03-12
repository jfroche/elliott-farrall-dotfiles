{ inputs
, ...
}:

_final: prev:
{
  flox = inputs.flox.packages.${prev.system}.default;
}
