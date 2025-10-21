let
  pkgs = import <nixpkgs> {};
  default = pkgs.callPackage ./default.nix {};
in
{
  inherit default;  

  hello-clang = (default.override {stdenv = pkgs.clangStdenv; }).overrideAttrs (
    oldAttrs: {
      name = "hello-clang";
    }
  );
  hello-patched = default.overrideAttrs (oldAttrs: {
    patches = [ ./hello.patch ];
    nativeBuildInputs = [ pkgs.help2man ];
    name = "hello-patched";
  });
}