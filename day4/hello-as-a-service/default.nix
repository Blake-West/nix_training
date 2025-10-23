let
  sources = import ./npins;
  pkgs = import sources.nixpkgs { };

  nixosEvaluation = pkgs.nixos [
    ./configuration.nix
    ./qemu-vm.nix
  ];
in

nixosEvaluation.config.system.build.vm
