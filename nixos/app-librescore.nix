{
  stdenv,
  lib,

  fetchurl,
  fetchzip,
  appimageTools,

  autoPatchelfHook,
  makeWrapper,

  glibc,
  glib,
  libGL,
  mesa,
  fuse2
}:

stdenv.mkDerivation rec {
  pname = "app-librescore";
  version = "v6.0.15";

  src = appimageTools.extractType2 {
    inherit pname version;

    src = fetchurl {
      url = "https://github.com/LibreScore/app-librescore/releases/download/${version}/LibreScore.AppImage";
      hash = "sha256-brVAUWRPqY04bcm0MV7yNhZsOwF2z/1CcYFGGaEDqwA=";
    };
  };

  nativeBuildInputs = [ autoPatchelfHook makeWrapper ];

  buildInputs = [
    glibc
    glib
    libGL
    mesa
    fuse2
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    cp -r . $out/
    makeWrapper $out/librescore $out/bin/librescore

    runHook postInstall
  '';

  postFixup = ''
    patchelf --set-rpath "${lib.makeLibraryPath buildInputs}" $out/librescore
  '';

  meta = {
    description = "Download sheet music";
    homepage = "https://github.com/LibreScore/app-librescore";
    platforms = [ "x86_64-linux" ];
    license = lib.licenses.mit;
    #maintainers = with lib.maintainers; [  ];
  };
}
