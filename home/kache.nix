# warning: slop!
{pkgs-unstable, ...}: let
  inherit (pkgs-unstable.stdenv.hostPlatform) system;

  # Skip the from-source build (~hundreds of crate fetches) by pulling the
  # static binary from kache's GitHub release. The Nix flake builds from
  # source; the release CI publishes linux-musl and macOS binaries.
  version = "0.16.0";
  hashes = {
    "aarch64-unknown-linux-musl" = "sha256-bqu2eGcCLuzb//5DwW51tcW1YZg3Qr2jyQCky0xQ5Kc=";
    "aarch64-apple-darwin" = "sha256-atgNO7sz19sXFdWpGe2991XcGcoi+oN5fGWRR/H54ik=";
  };
  target =
    {
      "aarch64-linux" = "aarch64-unknown-linux-musl";
      "aarch64-darwin" = "aarch64-apple-darwin";
    }.${
      system
    } or (throw "kache: unsupported system ${system}");

  kache = pkgs-unstable.stdenvNoCC.mkDerivation {
    pname = "kache";
    inherit version;
    src = pkgs-unstable.fetchurl {
      url = "https://github.com/kunobi-ninja/kache/releases/download/v${version}/kache-${target}.tar.gz";
      sha256 = hashes.${target};
    };
    dontConfigure = true;
    dontBuild = true;
    sourceRoot = ".";
    installPhase = ''
      runHook preInstall
      install -Dm755 kache $out/bin/kache
      runHook postInstall
    '';
    meta.mainProgram = "kache";
  };
in {
  home.packages = [kache];
  home.sessionVariables.RUSTC_WRAPPER = "kache";
}
