{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = { self, nixpkgs, flake-parts }@inputs: flake-parts.lib.mkFlake { inherit inputs; } {
    systems = [ "x86_64-linux" ];

    perSystem = {pkgs, system, ...} : {
        _module.args.pkgs = import self.inputs.nixpkgs {
          inherit system;
          overlays = [(import ./overlay.nix)];
          config.allowUnfree = true;
        };
      packages = {
        myapp = (pkgs.callPackage ./app { }).overrideAttrs {meta = {
          mainProgram = "MyApp";
        };};
      };
    };
  };
}
