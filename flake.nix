{
  outputs = inputs:
    let
      lib = inputs.snowfall-lib.mkLib { inherit inputs; src = ./.; };
    in
    lib.mkFlake
      {
        channels-config = {
          allowUnfree = true;
        };

        overlays = with inputs; [
          agenix.overlays.default
          code-insiders.overlays.default
          devshell.overlays.default
          flox.overlays.default
          rofi-plugins.overlays.default
        ];

        systems.modules.nixos = with inputs; [
          agenix.nixosModules.default
          impermanence.nixosModules.impermanence
          nix-index-database.nixosModules.nix-index
          nix-monitored.nixosModules.default
          stylix.nixosModules.stylix
        ];
        homes.modules = with inputs; [
          agenix.homeManagerModules.default
          impermanence.homeManagerModules.impermanence
          nix-index-database.hmModules.nix-index
          stylix.homeManagerModules.stylix
        ];

        systems.hosts = {
          broad = {
            modules = with inputs; [
              nixos-hardware.nixosModules.common-pc
              systems/x86_64-linux/broad/system
            ];
          };
          lima = {
            modules = with inputs; [
              nixos-hardware.nixosModules.framework-12th-gen-intel
              systems/x86_64-linux/lima/system
            ];
          };
          runner = {
            modules = with inputs; [
              nixos-hardware.nixosModules.common-pc
              systems/x86_64-linux/runner/system
              garnix-lib.nixosModules.garnix
              github-nix-ci.nixosModules.default
              # Move to shared modules
              nixos-facter-modules.nixosModules.facter
              disko.nixosModules.disko
            ];
          };
        };

        outputs-builder = channels: {
          formatter = inputs.treefmt-nix.lib.mkWrapper channels.nixpkgs ./checks/pre-commit/treefmt.nix;
        };

        templates = {
          python.description = "Python development environment";
          ruby.description = "Ruby development environment";
        };

      } // {
      # schemas = inputs.flake-schemas.schemas // inputs.extra-schemas.schemas;

      deploy = {
        sshUser = "root";
        nodes.lima = {
          hostname = "lima";
          profiles.system.path = inputs.deploy-rs.lib.x86_64-linux.activate.nixos inputs.self.nixosConfigurations.lima;
        };
        # nodes.runner = {
        #   hostname = "runner";
        #   profiles.system.path = inputs.deploy-rs.lib.x86_64-linux.activate.nixos inputs.self.nixosConfigurations.runner;
        # };
      };
    };

  inputs = {
    agenix = {
      url = "github:elliott-farrall/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
      inputs.systems.follows = "systems";
    };
    code-insiders = {
      url = "github:iosmanthus/code-insiders-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    deploy-rs = {
      url = "github:serokell/deploy-rs";
      inputs.flake-compat.follows = "flake-compat";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.utils.follows = "flake-utils";
    };
    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flox = {
      url = "github:flox/flox";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.pre-commit-hooks.follows = "pre-commit-hooks";
      # ignore additional dpendencies
    };
    garnix-lib = {
      url = "github:garnix-io/garnix-lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    github-nix-ci = {
      url = "github:juspay/github-nix-ci";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence = {
      url = "github:nix-community/impermanence";
    };
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    nixos-facter-modules = {
      url = "github:numtide/nixos-facter-modules";
    };
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware = {
      url = "github:NixOS/nixos-hardware";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.flake-compat.follows = "flake-compat";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rofi-plugins = {
      url = "github:elliott-farrall/rofi-plugins?rev=990fbb21bb5152ba116571704f1ba99d3dbb377f";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.pre-commit-hooks.follows = "pre-commit-hooks";
      inputs.snowfall-lib.follows = "snowfall-lib";
    };
    nix-monitored = {
      url = "github:ners/nix-monitored";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.flake-compat.follows = "flake-compat";
      inputs.flake-utils-plus.follows = "flake-utils-plus";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix";
      inputs.flake-compat.follows = "flake-compat";
      inputs.flake-utils.follows = "flake-utils";
      inputs.home-manager.follows = "home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.systems.follows = "systems";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Dependencies
    systems = {
      url = "github:nix-systems/default";
    };
    flake-compat = {
      url = "https://flakehub.com/f/edolstra/flake-compat/1.tar.gz";
    };
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };
    flake-utils-plus = {
      url = "github:gytis-ivaskevicius/flake-utils-plus";
      inputs.flake-utils.follows = "flake-utils";
    };

    # Schemas
    # For when https://github.com/NixOS/nix/pull/8892 gets merged
    flake-schemas = {
      url = "github:DeterminateSystems/flake-schemas";
    };
    extra-schemas = {
      url = "github:elliott-farrall/extra-schemas";
    };
  };

  nixConfig = {
    extra-substituters = [
      "https://cache.garnix.io"
      "https://nix-community.cachix.org"
      "https://cache.flox.dev"
    ];
    extra-trusted-public-keys = [
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "flox-cache-public-1:7F4OyH7ZCnFhcze3fJdfyXYLQw/aV7GEed86nQ7IsOs="
    ];
  };
}
