{
  lib,
  fetchurl,
  appimageTools
}:

let
  pname = "mscore4portable";
  version = "4.5.2";
  patchnumber = "251141401";

  src = fetchurl {
    url = "https://github.com/musescore/MuseScore/releases/download/v${version}/MuseScore-Studio-${version}.${patchnumber}-x86_64.AppImage";
    hash = "sha256-0BC2Rkx4tNojB3608Jb5Sa5ousTICaiwCKDPv0jiYKU=";
  };

  appimageContents = appimageTools.extract {
    inherit pname version src;
  };
in
appimageTools.wrapType2 {
  inherit pname version src;

  extraInstallCommands = ''
    cp -r ${appimageContents}/share $out/share
  '';

  meta = {
    description = "Music notation and composition software";
    homepage = "https://musescore.org";
    platforms = [ "x86_64-linux" ];
    license = lib.licenses.gpl3Only;
    #maintainers = with lib.maintainers; [  ];
    mainProgram = "mscore4portable";
  };
}
