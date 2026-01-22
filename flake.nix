{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    mnw.url = "github:Gerg-L/mnw/75bb637454b0fbbb5ed652375a4bf7ffd28bcf6f"; # Before broken commit
    # mnw.url = "github:Gerg-L/mnw/ea993bf7fe0c4999abb0b6e79c9dafb82a907700"; # After broken commit
  };

  outputs = { self, nixpkgs, mnw }:
  let
    lib = nixpkgs.lib;
    supportedSystems = [ "x86_64-linux" "aarch64-darwin" "x86_64-darwin" ];
    forAllSystems = function: lib.genAttrs
      supportedSystems
      (system: function nixpkgs.legacyPackages.${system});
  in {
    packages = forAllSystems (pkgs: {
      default = import ./default.nix { inherit pkgs mnw; };
    });

    devShells = forAllSystems (pkgs: {
      default = pkgs.mkShellNoCC {
        packages = lib.singleton self.packages.${pkgs.stdenv.hostPlatform.system}.default.devMode;
      };
    });
  };
}
