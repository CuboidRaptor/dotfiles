{
  stdenv,
  lib,
  fetchurl,
  dpkg,

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

stdenv.mkDerivation rec {
  pname = "tx16wx";
  version = "3.7.0h";

  src = fetchurl {
    name = "tx16wx-software-sampler-${version}-amd64.deb";
    # make it shorter cuz I don't like long lines
    url = lib.concatStrings [
      "https://www.tx16wx.com/download/"
      "tx16wx-software-sampler-3-linux-x64-debian-2/"
      "?wpdmdl=19516&refresh=680e7e1227cc11745780242"
    ];
    hash = "sha256-Lddcc84SnJOc7OIZX66OrBcA6r39/s2zLjkSYG/UER8=";
  };

  nativeBuildInputs = [
    dpkg
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
    mv ./usr/lib $out/lib
    mv ./usr/share $out/share

    runHook postInstall
  '';

  # patch the binaries so they find their libs
  postFixup = ''
    for file in \
      $out/lib/vst/TX16Wx.vst.so \
      $out/lib/vst3/TX16Wx.vst3/Contents/x86_64-linux/TX16Wx.so \
      $out/lib/clap/TX16Wx.clap
    do
      patchelf --set-rpath "${lib.makeLibraryPath buildInputs}" $file
    done
  '';

  meta = {
    description = "A sampler plug-in for the creative musician";
    homepage = "https://www.tx16wx.com";
    #license = lib.licenses.;
    #maintainers = with lib.maintainers; [  ];
  };
}
