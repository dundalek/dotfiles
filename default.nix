with import <nixpkgs> {};
stdenv.mkDerivation {
  name = "dotfiles-env";
  buildInputs = [
    stow
  ];
}
