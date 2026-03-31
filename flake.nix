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
      version = "3.0.1";

      assets = {
        "autoexec.ipxe" = "sha256-UN75voeIJ7ZD5c3Qq4gV039IHO+LlMC/6kd6tkxe2b0=";
        "netboot.xyz-arm64-snp.efi" = "sha256-tMzCSslqoBjeKczyYsSd35gWGGIsI/pcXXBGYhdN62M=";
        "netboot.xyz-arm64-snponly.efi" = "sha256-Bwsp4e+lt9k1atjO9woNhwmmHenNc6teVs6t3oVGuXc=";
        "netboot.xyz-arm64.efi" = "sha256-ZJWZVEW8opiJ6GO/5lIFHnUWJoqT4+9+Lo+VOZuutSo=";
        "netboot.xyz-arm64.img" = "sha256-d5fTR+pUOD7FGT32EqTJdN093l20HfQWtfPiluLm2ZA=";
        "netboot.xyz-arm64.iso" = "sha256-c0k8xVCBSw47eegIteXw1SvAKrRxXR57LuIisTgn1IA=";
        "netboot.xyz-linux.bin" = "sha256-MfyVxgtjf4d95feLqh63goZj665X521tuX8qQfDezJA=";
        "netboot.xyz-metal-arm64-snp.efi" = "sha256-1e0fv4/kLKBQBy5Av6LJ5/p5g7TJkuuAxLkv657NFyE=";
        "netboot.xyz-metal-arm64-snponly.efi" = "sha256-oNsg5tpYepucV1GQSPtcZa2u81wRGx7G0apCYo4t/xo=";
        "netboot.xyz-metal-arm64.efi" = "sha256-YFJsIZjM4JcBYSNwcaNL0BhCIGi4gaLzp8UOI/8DHRU=";
        "netboot.xyz-metal-snp.efi" = "sha256-XFjzxiW2lgul5et3AD4mOL+g6mTme4FqCx2n9UKzkao=";
        "netboot.xyz-metal-snp.efi.dsk" = "sha256-z8N5cUfh8A1lz07n4bLEAUsPQ59Nhylo2WNTpx/SNKo=";
        "netboot.xyz-metal-snponly.efi" = "sha256-dMhLy5jxAu16bbdYxZgMeiwC3+SDk0knORuqg4dqZBw=";
        "netboot.xyz-metal.efi" = "sha256-4MuLcPJAZUSNjePoM1ANPOGNoARsjmCN6isLH6eBiaE=";
        "netboot.xyz-metal.efi.dsk" = "sha256-krevHsRU3qzj0v2ZOiFnfmeEP0j3/4AODTZeKwJ8ucA=";
        "netboot.xyz-metal.kpxe" = "sha256-ga1TmE0GEVTLXtfTqvs6VJIW646zrmcQpjvNGRHlbKs=";
        "netboot.xyz-multiarch.img" = "sha256-G5m5ip6f9DNUavxl491AmVbhPDzDm1nPsAiDiYg/Ygk=";
        "netboot.xyz-multiarch.iso" = "sha256-pVB7Db+CUv9gRN5CqH0cV28YYECbbwdWCvkuLM2iDiI=";
        "netboot.xyz-sb-arm64.img" = "sha256-cdWjb9CTVdh4dK3k9Q44oaFw0Pk6F7yTznFegt2BNvM=";
        "netboot.xyz-sb-arm64.iso" = "sha256-C65MWV0zr2mQkjCods4nWIokPt0DTRojqDL0Tq1wJmE=";
        "netboot.xyz-sb.img" = "sha256-kcIU9E2ONgnozdq0KgSRE/eW0jws7oSGGeWT2jWQ0Zk=";
        "netboot.xyz-sb.iso" = "sha256-5QzdseyswZI1WZChYlZuQ5disqNgRFWJhwyRUkKOwD0=";
        "netboot.xyz-snp.efi" = "sha256-V9BLBVcRHD4qbSkp8nppAx3iTuHH5jIwvcEh1A04LK8=";
        "netboot.xyz-snp.efi.dsk" = "sha256-gopawJUHvpI7vCkVKxznVdI2VBOg1qzmyhoVKafuAxE=";
        "netboot.xyz-snponly.efi" = "sha256-hlT48Tos4DSvg8AodfgfT1DTJx8fbBfKHEynObLACRY=";
        "netboot.xyz-undionly.kpxe" = "sha256-XSz9MVbJ4PC8C8HP6oqROa4kAF9FKEbv4RbZcqNFA8o=";
        "netboot.xyz.dsk" = "sha256-/H0Fo8Eo06WyDUauLX40P32AKqUJW0VFAkQI9E2z7Y4=";
        "netboot.xyz.efi" = "sha256-/MOoApIQjXjoQgb0Q075kP6IxbuDuzaHl6E14e7nzYM=";
        "netboot.xyz.efi.dsk" = "sha256-GNqNlfarYMNTyznX4lzQH/3ZUxxaNy7jjltMztsR7+c=";
        "netboot.xyz.img" = "sha256-aYHkbqDLFO6xFBTZqBK9dBrtZKPT9YgufP+FerclIeA=";
        "netboot.xyz.iso" = "sha256-FBYZHJblWw7gyhiZNJkopM99VgQIZavHoY91gYzmOjc=";
        "netboot.xyz.kpxe" = "sha256-bJDTKX6oMWv/25+apWa58w8VYQeWHMA8u8a+RL4+mjM=";
        "netboot.xyz.lkrn" = "sha256-jRPqz/sdpJwuGTmtaaW/CMr1Ig35E8Oxh+UecgpYNyc=";
        "netboot.xyz.pdsk" = "sha256-Y83++gxgW5grooRvZ1RLTfZ0qu/WHd0n7ot4hSopIVY=";
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
