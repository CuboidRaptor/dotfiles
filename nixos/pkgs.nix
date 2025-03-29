{ config, pkgs, inputs, winepinnedpkgs, ... }:

{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  # Install/enable option programs.
  programs = {
    firefox.enable = true;
    steam.enable = true;
    neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
      viAlias = true;
    };
    lazygit.enable = true;
    tmux.enable = true;
    nh.enable = true; # nix helper installation/config!
  };

  ## fuck me does this cause problems
  ## (breaks podman, breaks distrobox, takes 45645,6,456 morbillion hours to compile)
  #virtualisation.virtualbox.host = {
  #  enable = true;
  #  enableExtensionPack = true;
  #};
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

  xdg.portal = { # for flatpak
    enable = true; 
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
  services = {
    gvfs.enable = true; # for trash-cli
    flatpak = {
      enable = true;
      packages = [ # requires nix-flatpak flake
        "io.github.everestapi.Olympus"
      ];
    };
    earlyoom = {
      enable = true;
      enableNotifications = true;
    };
  };

  # sublime text 4 and some other packages need it
  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1w"
  ];

  environment.systemPackages = let
    # NixLDWrapper code from bvngee https://bvngee.com/blogs/using-python-virtualenvs-in-nixos
    # Some dynamic executables are unpatched but are loaded by patched nixpkgs
    # executables, and therefore never pick up NIX_LD_LIBRARY_PATH. For
    # example, interpreters that use dynamically linked libraries, like python3
    # libraries run by nixpkgs' python. This wraps the interpreter for ease of
    # use with those executables. WARNING: Using LD_LIBRARY_PATH like this can
    # override some of the program's dylib links in the nix store; this should
    # be generally ok though
    makeNixLDWrapper = program: (pkgs.runCommand "${program.pname}-nix-ld-wrapped" { } ''
      mkdir -p $out/bin
      for file in ${program}/bin/*; do
        new_file=$out/bin/$(basename $file)
        echo "#! ${pkgs.bash}/bin/bash -e" >> $new_file
        echo 'export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$NIX_LD_LIBRARY_PATH"' >> $new_file
        echo 'exec -a "$0" '$file' "$@"' >> $new_file
        chmod +x $new_file
      done
    '');
  in
  ((with pkgs; [
    jdk # programming languages stuff
    gcc
    libgcc
    (makeNixLDWrapper python313Full)
    nodejs
    clang-tools
    clang
    nil

    starship # dev stuff/deps
    zip
    unzip
    curl
    eza
    bat
    fastfetch
    btop
    tmuxp
    zenity
    gh
    git
    lf
    trash-cli
    imagemagick
    lutgen
    xmousepasteblock
    http-server
    xclip
    glib
    fuse
    fzf
    ripgrep
    fd

    gparted # apps
    firefox-devedition-bin
    sublime4
    (vesktop.override {
      withMiddleClickScroll = true;
    })
    speedcrunch
    anki
    flameshot
    vlc
    thunderbird
    winetricks
    (vivaldi.overrideAttrs (
        oldAttrs: {
          dontWrapQtApps = false;
          dontPatchELF = true;
          nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [ pkgs.kdePackages.wrapQtAppsHook ];
        }
    ))
    vivaldi-ffmpeg-codecs
    remmina
    pavucontrol
    wezterm
    librewolf
    kdePackages.okular
    kdePackages.kolourpaint
    gimp
    gpick
    dconf-editor
    distrobox
    libreoffice
    qdirstat
    mate.engrampa

    musescore # audio stuff
    audacity
    dl-librescore
    reaper
    #yabridge
    #yabridgectl

    lutris # games and stuff
    (prismlauncher.override {
      jdks = [
        jdk8
        jdk17
        jdk21
      ];
    })
    mindustry
    owmods-gui
    ckan

    seahorse # xfce and theming stuff
    xfce.xfce4-whiskermenu-plugin
    xfce.xfce4-docklike-plugin
    xfce.xfce4-systemload-plugin
    xfce.xfce4-xkb-plugin
    catppuccin
    catppuccin-cursors.mochaDark
    (catppuccin-papirus-folders.override {
      flavor = "latte";
      accent = "maroon";
    })
    (colloid-gtk-theme.override { # this is used only for window decoration
      themeVariants = [ "red" ];
      colorVariants = [ "light" ];
      tweaks = [
        "catppuccin"
        "rimless"
      ];
    })
  ]) ++ (with winepinnedpkgs; [
    wineWowPackages.staging
  ]));

  programs.thunar.plugins = [
    pkgs.xfce.thunar-archive-plugin
  ];

  ### nixos compat stuff
  # nix-ld because I'm lazy and it works
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      alsa-lib at-spi2-atk at-spi2-core atk cairo # taken from u/henry_tennenbaum, who took it from someone else
      cups curl dbus expat fontconfig
      freetype fuse3 gdk-pixbuf glib gtk3
      icu libGL libappindicator-gtk3 libdrm libglvnd
      libnotify libpulseaudio libunwind libusb1 libuuid
      libxkbcommon libxml2 mesa nspr nss
      openssl pango pipewire stdenv.cc.cc systemd
      vulkan-loader xorg.libX11 xorg.libXScrnSaver
      xorg.libXcomposite xorg.libXcursor xorg.libXdamage
      xorg.libXext xorg.libXfixes xorg.libXi
      xorg.libXrandr xorg.libXrender xorg.libXtst
      xorg.libxcb xorg.libxkbfile xorg.libxshmfence zlib
    ];
  };
  # also envfs it also makes my life easier
  services.envfs.enable = true;
  programs.appimage = {
    # screw with appimages to make them run
    enable = true;
    binfmt = true;
  };
}
