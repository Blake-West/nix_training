let
  sources = import ./npins;
  pkgs = import sources.nixpkgs {
    overlays = [
      (import ./overlay.nix)
      (import ./overlay-patched.nix)
    ];
  };

  patch-lib = import ./substitute-char-in-lib.nix;

  libB-fixup = patch-lib {lib = pkgs.libB; before = "b"; after = "y"; };
  libA-fixup = (patch-lib {
    lib = pkgs.libA;
    before = "a";
    after = "x";
  }).override {
    libD = libD-fixup; 
    libC = libC-fixup;
  };

  libD-fixup = patch-lib {lib = pkgs.libD; before = "d"; after = "w"; };

  libC-fixup = patch-lib {lib = pkgs.libC; before = "C"; after = "Z"; };

in
{
  app-fixed = pkgs.myapp.override {
    libA = libA-fixup;
    libB = libB-fixup;
  };
  inherit (pkgs)
    libA
    libB
    libC
    libD
    myapp
    ;

  myapp-static = pkgs.pkgsStatic.myapp;
  myapp-win64 = pkgs.pkgsCross.mingwW64.myapp;
  myapp-aarch64 = pkgs.pkgsCross.aarch64-multiplatform.myapp;

  devShell = pkgs.mkShell {
    inputsFrom = with pkgs; [
      libA
      libB
      libC
      libD
      myapp
    ];
    nativeBuildInputs = [ pkgs.graphviz ];
  };
}
