{
  description = "netboot.xyz boot files (netbootxyz/netboot.xyz).";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pin = import ./pin.nix;
        inherit (pin) version assets;
        pkgs = import nixpkgs { inherit system; };

        sanitizeName = name: builtins.replaceStrings [ "." ] [ "-" ] name;

        mkBootFile = name: hash: pkgs.runCommand (sanitizeName name) { } ''
          mkdir -p $out
          cp ${builtins.fetchurl {
            url = "https://github.com/netbootxyz/netboot.xyz/releases/download/${version}/${name}";
            sha256 = hash;
          }} $out/${name}
        '';

        bootFiles = builtins.listToAttrs (builtins.map
          (name: {
            name = sanitizeName name;
            value = mkBootFile name assets.${name};
          })
          (builtins.attrNames assets));

        update-version = pkgs.writeShellApplication {
          name = "update-version";
          text = ''exec ${./update-version.sh} "$@"'';
        };
        update-branches = pkgs.writeShellApplication {
          name = "update-branches";
          text = ''exec ${./update-branches.sh} "$@"'';
        };
      in
      {
        packages = bootFiles // {
          inherit update-version update-branches;
          default = bootFiles."netboot-xyz-iso";
        };
      });
}
