let
  sources = import ./npins;
  pkgs = import sources.nixpkgs { };
in

pkgs.testers.runNixOSTest ./test.nix
