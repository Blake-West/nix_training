let 
  patch-lib =
  {lib, before, after}:
  lib.overrideAttrs {
    postPatch = ''
      substituteInPlace main.cpp --replace-fail '"${before}"' '"${after}"'
    '';
  };

in 
final: prev: {
  libA = patch-lib { lib = prev.libA; before = "a"; after = "x"; };

  libB = patch-lib {lib = prev.libB; before = "b"; after = "y"; };

  libC = patch-lib {lib = prev.libC; before = "C"; after = "Z"; };

  libD = patch-lib {lib = prev.libD; before = "d"; after = "w"; };

}