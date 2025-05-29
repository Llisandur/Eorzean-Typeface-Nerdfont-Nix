{
  lib,
  stdenvNoCC,
  pkgs,
  nerd-font-patcher,
}:

stdenvNoCC.mkDerivation rec {
  pname = "eorzean-typeface-nerdfont";
  version = "1.051";

  src = pkgs.fetchurl {
    url = "https://github.com/karaipsum/Eorzean-Typeface/releases/download/v${version}/AugmentedNeo-Eorzean-Regular.otf";
    hash = "sha256-SeIJ6uQjCeV0IwJoSt557nIHBk1l6J+N7ef7LzS2ugs=";
  };

  dontUnpack = true;

  nativeBuildInputs = [
    nerd-font-patcher
  ];

  buildPhase = ''
    runHook preBuild
    nerd-font-patcher --adjust-line-height --progressbars --complete $src
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    install -Dm644 AugmentedNeoEorzeanNerdFont-Regular.otf -t $out/share/fonts/opentype
    runHook postInstall
  '';

  meta = {
    description = "Nerdfont patch of Augmented Neo-Eorzean";
    homepage = "https://github.com/karaipsum/Eorzean-Typeface";
    license = lib.licenses.mit;
    platforms = lib.platforms.all;
  };
}
