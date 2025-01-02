{ lib
, ...
}:

{
  imports = [
    ./locales/uk.nix
  ];

  options = {
    locale = lib.mkOption {
      type = lib.types.enum [
        "uk"
      ];
      default = "uk";
      description = "The locale to use.";
    };
  };

  config = {
    console.useXkbConfig = true;
    services.kmscon.useXkbConfig = true;
  };
}
