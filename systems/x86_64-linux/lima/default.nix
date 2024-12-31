{ ...
}:

{
  imports = [
    ./config
    ./overrides
  ];

  profiles.uos.enable = true;

  /* ---------------------------------- Theme --------------------------------- */

  programs.dconf.enable = true;

  catnerd = {
    enable = true;

    flavour = "macchiato";
    accent = "pink";

    cursor.size = 24;

    fonts.main = {
      family = "Ubuntu";
      size = 10;
    };
    fonts.mono = {
      family = "DroidSansM";
      size = 14;
    };
  };

  /* ---------------------------------- Shell --------------------------------- */

  shell = "zsh";

  /* --------------------------------- Greeter -------------------------------- */

  greeter = "tuigreet";

  /* --------------------------------- Locker --------------------------------- */

  locker = "hyprlock";

  /* ---------------------------------- Tools --------------------------------- */

  tools = {
    android.enable = true;
    ansible.enable = true;
  };

}
