with import <nixpkgs> { };
with import
  (
    builtins.fetchTarball "https://github.com/numtide/treefmt-nix/archive/refs/heads/master.tar.gz"
  );

mkShell {
  nativeBuildInputs = [
    (mkWrapper pkgs {
      projectRootFile = "release.nix";
      programs = {
        clang-format.enable = true;
        nixfmt.enable = true;
      };
    })
  ];
  inputsFrom = [ (import ./default.nix { }) ];
  shellHook = ''
    echo "Welcome to the dev-shell of hello-nix"
    export PS1="hello-nix 👋> "
  '';
}
