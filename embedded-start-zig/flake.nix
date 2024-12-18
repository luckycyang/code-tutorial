{
  description = "A devShell example";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
        };
      in
        with pkgs; {
          devShells = {
            default = mkShell {
              buildInputs = [
                openssl
                pkg-config
                eza
                fd
                zig
                zls
                # youcan also rust-bin.{stable, beta, nightly}.{lastest, "2121-01-01"...}.default
                # where override {extensions = []; targets = [];}
              ];

              shellHook = ''
                alias ls=eza
                alias find=fd
              '';
            };
          };
        }
    );
}
