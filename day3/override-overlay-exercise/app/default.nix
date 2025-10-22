{
  stdenv,
  lib,
  cmake,
  libA,
  libB,
}:

stdenv.mkDerivation {
  name = "myapp";
  src = lib.fileset.toSource {
    root = ./.;
    fileset = lib.fileset.unions [
      ./CMakeLists.txt
      ./main.cpp
    ];
  };

  nativeBuildInputs = [ cmake ];
  buildInputs = [
    libA
    libB
  ];

  cmakeFlags = [ "-DBUILD_SHARED_LIBS:BOOL=ON" ];
}
