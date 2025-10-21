let
  pkgs = import <nixpkgs> { };
in
builtins.derivation {
  name = "mini-hello";
  builder = "${pkgs.bash}/bin/bash";
  args = [ ./builder.sh ];
  system = builtins.currentSystem;

  # env = [
  # "${pkgs.gcc}/bin/" "${pkgs.gnumake}/bin/" "${pkgs.coreutils}/bin/"
  # ];
  PATH = pkgs.lib.makeBinPath [
    pkgs.gcc
    pkgs.gnumake
    pkgs.coreutils
  ];
  #PATH = "${pkgs.gcc}/bin/:${pkgs.gnumake}/bin/:${pkgs.coreutils}/bin/";
  src = ./.;
}

