let
  pkgs = import <nixpkgs> { };
in
rec {
  hello-nix = import ./hello-nix.nix pkgs;

  bye-nix = hello-nix.overrideAttrs (_: {
    name = "bye-nix";
    patchPhase = "substituteInPlace hello.cpp --replace \"Helo, \" \"Bye, \"";
  });
}
