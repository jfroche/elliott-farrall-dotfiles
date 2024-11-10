{ ...
}:

{
  programs.direnv = {
    enable = true;
    silent = true;
    config = {
      global.warn_timeout = 0;
    };
    nix-direnv.enable = true;
  };
}
