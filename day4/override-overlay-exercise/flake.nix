{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = { self, nixpkgs, flake-parts }@inputs: flake-parts.lib.mkFlake { inherit inputs; } {
    systems = [ "x86_64-linux" "aarch64-linux" ];

    perSystem = {pkgs, system, ...} : {
      _module.args.pkgs = import self.inputs.nixpkgs {
        inherit system;
        overlays = [(import ./overlay.nix) (import ./overlay-patched.nix)];
        config.allowUnfree = true;
      };
      packages = {
        myapp = pkgs.myapp.overrideAttrs {meta = {
          mainProgram = "MyApp";
        };};
      };
    };
  };
}
