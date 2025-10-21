let
  pkgs = import <nixpkgs> { };
in
pkgs.stdenv.mkDerivation {
  name = "hello";
  
  src = builtins.fetchTarball "https://gnu.mirror.constant.com/hello/hello-2.9.tar.gz";
}