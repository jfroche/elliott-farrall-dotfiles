{ ...
}:

{
  age.secrets.github-pat = {
    file = ./github-pat.age;
    substitutions = [ "/etc/nix/nix.conf" ];
  };

  documentation.nixos.enable = false;

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users = [ "root" "@wheel" ];
    access-tokens = "github.com=@github-pat@";
    use-xdg-base-directories = true;
    auto-optimise-store = true;
    min-free = "${toString (50 * 1024 * 1024 * 1024)}";
  };

  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      extraArgs = "--keep 30 --keep-since 14d";
    };
  };
}
