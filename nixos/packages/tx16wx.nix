{
  stdenv,
  fetchurl,
  dpkg,
  autoPatchelfHook,

  glib,
  glibc,
  xorg,
  xcb-util-cursor,
  xcbutilxrm,
  harfbuzz,
  pango,
  cairo,
  fontconfig,
  freetype,
  libxkbcommon,
  liburing,
  libsecret,
  libxml2,
}:

stdenv.mkDerivation {
  pname = "tx16wx";
  version = "3.7.0h";

  src = fetchurl {
    url = "https://www.tx16wx.com/download/tx16wx-software-sampler-3-linux-x64-debian-2/?wpdmdl=19516";
    hash = "sha256-Dj6G5hSkc+ZTACbCiKB9vW+Y1eqRh9ErC7JmQ1Pr+B0=";
  };

  nativeBuildInputs = [
    dpkg
    autoPatchelfHook
  ];

  buildInputs = [
    glib
    glibc
    stdenv.cc.cc
    xorg.libxcb
    xorg.xcbutil
    xorg.xcbutilwm
    xorg.xcbutilkeysyms
    xcb-util-cursor
    xcbutilxrm
    harfbuzz
    pango
    cairo
    fontconfig
    freetype
    libxkbcommon
    liburing
    libsecret
    libxml2
  ];

  # download/extract the deb package
  unpackPhase = ''
    runHook preUnpack

    dpkg-deb -x $src . # this creates ./usr/ in the current folder

    runHook postUnpack
  '';

  # move the folders to the right places so they get linked
  installPhase = ''
    runHook preInstall

    mkdir -p $out
    cp -r ./usr/* $out

    runHook postInstall
  '';

  meta = {
    description = "A sampler plug-in for the creative musician";
    homepage = "https://www.tx16wx.com";
    platforms = [ "x86_64-linux" ];
    #license = lib.licenses.;
    #maintainers = with lib.maintainers; [  ];
  };
}
