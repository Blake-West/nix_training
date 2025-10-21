let
  pkgs = import <nixpkgs> { };
in
pkgs.stdenv.mkDerivation {
  name = "hello";
  
  src = pkgs.fetchzip {
    url = "https://gnu.mirror.constant.com/hello/hello-2.9.tar.gz";
    hash = "sha256-1aFSTdB6F9qR8hch6QTZzQm5rgEhh1SbNIfFs61FsK8=";
  };

  configurePhase = ''
    ./configure --prefix=$out
  '';

  buildPhase = ''
    make
  '';

  doCheck = true;
  checkPhase = ''
    make check
  '';

  installPhase = ''
    make install
  '';

  patches = [
    ./hello.patch
  ];

  nativeBuildInputs = [
    pkgs.help2man
  ];
}