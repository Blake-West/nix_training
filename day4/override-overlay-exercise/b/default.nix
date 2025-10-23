{
  stdenv,
  lib,
  cmake,
}:

stdenv.mkDerivation {
  name = "libb";
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
