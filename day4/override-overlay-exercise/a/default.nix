{
  stdenv,
  lib,
  cmake,
  libC,
  libD,
}:

stdenv.mkDerivation {
  name = "libA";
  src = lib.fileset.toSource {
    root = ./.;
    fileset = lib.fileset.unions [
      ./include
      ./CMakeLists.txt
      ./main.cpp
    ];
  };

  nativeBuildInputs = [ cmake ];
  buildInputs = [ libC ];
  propagatedBuildInputs = [ libD ];

  cmakeFlags = [ "-DBUILD_SHARED_LIBS:BOOL=ON" ];
}
