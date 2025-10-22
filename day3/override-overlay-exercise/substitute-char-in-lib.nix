{lib, before, after}:
  lib.overrideAttrs {
    postPatch = ''
      substituteInPlace main.cpp --replace-fail '"${before}"' '"${after}"'
    '';
}