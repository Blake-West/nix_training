{
  stdenv,
  lib,
  cmake,
}:

stdenv.mkDerivation {
  name = "libD";
  src = lib.fileset.toSource {
    root = ./.;
    fileset = lib.fileset.unions [
      ./include
      ./CMakeLists.txt
      ./main.cpp
    ];
  };

  nativeBuildInputs = [ cmake ];
}
