{
  description = "netboot.xyz boot files";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { self
    , nixpkgs
    , flake-utils
    , ...
    }: flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = nixpkgs.legacyPackages.${system};

      # Release: https://github.com/netbootxyz/netboot.xyz/releases
      version = "3.0.0";

      assets = {
        "netboot.xyz-arm64-snp.efi" = "sha256-WRg0mqHFodjhNmEJE/L5G0kFRlOWZPgvT067xd6oC8w=";
        "netboot.xyz-arm64-snponly.efi" = "sha256-CkUDJLSP23Zy49h9/vkJyOLfOPqqRiPm8pU+GUyQqKU=";
        "netboot.xyz-arm64.efi" = "sha256-0i3mKD5t4z3YsvXyNIl0n/4D/pEzoz2meAmqhb+f/9A=";
        "netboot.xyz-arm64.img" = "sha256-JQueBhxaBY1uPN16P8I1cYAKeODHCbFfvmHLxQll91g=";
        "netboot.xyz-arm64.iso" = "sha256-TDnvtcyGYf9ghoRdIB+V2mmKsL3cEjBb+U/KgFq+cHA=";
        "netboot.xyz-linux.bin" = "sha256-j8MMyQHAZB1BgN4CvpFdEgv+xgOBCjAJ4Ztkmo6V2Fk=";
        "netboot.xyz-metal-arm64-snp.efi" = "sha256-hHaQNmrzMXaq89ZZWPCe4Z/haSevFiAqw933PhaNosc=";
        "netboot.xyz-metal-arm64-snponly.efi" = "sha256-oB78qT/cSoU5dWPQqFieBcx2MJzfToXi0w5Xl90IOnI=";
        "netboot.xyz-metal-arm64.efi" = "sha256-WR0YovQxswkkNAlBMvwpsJ0UCZldPPsP2Gx1KJgp/zk=";
        "netboot.xyz-metal-snp.efi" = "sha256-od8qvRH2PosshEQGMf2K70zPudosuMBOZA5tWTYApf4=";
        "netboot.xyz-metal-snp.efi.dsk" = "sha256-fBTxRsqLjJSzdCYUWUeT0lWZlz8mKhf8rCoTARcfv9g=";
        "netboot.xyz-metal-snponly.efi" = "sha256-AiXDWNeKzbzjSSoAGXG2wgjl9GZ+o/RXyqHllL7ge/I=";
        "netboot.xyz-metal.efi" = "sha256-+hoWNBkxgyjBKynhtVrZpUMzMiwYUKqHtBDvYlY4SmA=";
        "netboot.xyz-metal.efi.dsk" = "sha256-z+6zCEmY6VI1/oz6W3aBsxeUuSduis/C8787UeUw5Ss=";
        "netboot.xyz-metal.kpxe" = "sha256-IhRkU1gQqA9O5aQk7UEnW3MArXo/uWzfYc2uznsgiM0=";
        "netboot.xyz-multiarch.img" = "sha256-GSKSYBICrMYOsB0U9cKTqfk7GHqXU2D88Qt8/DbPqRM=";
        "netboot.xyz-multiarch.iso" = "sha256-lx/txlXZK+Fy0M7IbR+MH0xZxA+N8ujbcSEA4LEYaso=";
        "netboot.xyz-snp.efi" = "sha256-pgimXkjctBEm6zu5aUoNFZ91UtmR+IoOmRugbh1or4c=";
        "netboot.xyz-snp.efi.dsk" = "sha256-kjZpM8Sxpu7R7PV2o7URjLXnie0RUBoBBA7ZudT62Fs=";
        "netboot.xyz-snponly.efi" = "sha256-8ZrM3EES2hsrnqhcbJ2CcS1DUgx0IVeA4dO2b8CoFnc=";
        "netboot.xyz-undionly.kpxe" = "sha256-ppu9mtjrHctMY6RIgUqjl2LkpsErnJmI20rymntqhXo=";
        "netboot.xyz.dsk" = "sha256-jz6hgMaoznJaaFSvqWEAUOkSBefBbL8NgYJv+BTndfc=";
        "netboot.xyz.efi" = "sha256-xvxF4mPgzcZO6j616FqozL8ObuMRuqKu87TtiPkHa+0=";
        "netboot.xyz.efi.dsk" = "sha256-8xuEzKRj+QdwMEpX+NdgFBjyfE1+4GUCjAinv4kA3AA=";
        "netboot.xyz.img" = "sha256-GzNyRgW45Idoqesc3R/xacZvrX5kj1xrM84jrYcgaHs=";
        "netboot.xyz.iso" = "sha256-aHzDjeyLEcxNkehjhkXGg6a3jgHwU87kl4eGsfHKFM0=";
        "netboot.xyz.kpxe" = "sha256-yf4Ermoo/h4rErv/ebrDyz/2lgK1dG4hGbC2cyUcs9M=";
        "netboot.xyz.lkrn" = "sha256-950XOaf3g4OPi6W8ELl0P/0TZ8fLfXbjb9WsEfhVswY=";
        "netboot.xyz.pdsk" = "sha256-G+zc+vSzoAntK92VAu1M9k/+J8UnV6JRlZ8zJazl+Y0=";
      };

      sanitizeName = name:
        builtins.replaceStrings [ "." ] [ "-" ] name;

      mkBootFile = name: hash: pkgs.runCommand (sanitizeName name) { } ''
        mkdir -p $out
        cp ${builtins.fetchurl {
          url = "https://github.com/netbootxyz/netboot.xyz/releases/download/${version}/${name}";
          sha256 = hash;
        }} $out/${name}
      '';
    in
    {
      packages = builtins.listToAttrs (builtins.map
        (name: {
          name = sanitizeName name;
          value = mkBootFile name assets.${name};
        })
        (builtins.attrNames assets));
    });
}
