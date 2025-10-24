pkgs:
with pkgs;

stdenv.mkDerivation {
  name = "hello-nix";

  src = ./.;

  buildInputs = [
    cmake
    ninja
  ];
}
