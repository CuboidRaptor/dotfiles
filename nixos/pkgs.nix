{ config, pkgs, inputs, ... }:

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
    zoxide.enable = true;
    zsh.enable = true;
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
    config.common.default = "gtk";
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
  (with pkgs; [
    jdk # programming languages stuff
    gcc
    (makeNixLDWrapper python313Full)
    nodejs
    clang-tools
    clang
    nil
    bash-language-server

    zip # dev stuff/deps
    unzip
    curl
    libgtop
    eza
    bat
    fastfetch
    btop
    tmuxp
    zenity
    gh
    git
    tldr
    numlockx
    trash-cli
    imagemagick
    xmousepasteblock
    http-server
    xclip
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
    obs-studio
    wineWowPackages.staging
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
    shotcut
    yt-dlg
    musescore # audio stuff
    audacity
    dl-librescore

    (prismlauncher.override { # games and stuff
      jdks = [
        jdk8
        jdk17
        jdk21
      ];
    })
    mindustry
    owmods-gui
    ckan
    gamemode
    lutris
    umu-launcher

    # theming stuff
    catppuccin-cursors.mochaDark
    (catppuccin-papirus-folders.override {
      flavor = "latte";
      accent = "maroon";
    })
    ((colloid-gtk-theme.overrideAttrs (oldAttrs: {
      # patch padding between windows icons
      postInstall = (oldAttrs.postInstall or "") + ''
        printf "\n/* PATCH for panel window icon sizes */
        .grouped-window-list-item-box {
          width: 40px !important;
        }" >> "$out/share/themes/Colloid-Red-Dark-Catppuccin/cinnamon/cinnamon.css"
      '';
    })).override {
      themeVariants = [ "red" ];
      colorVariants = [ "dark" ];
      tweaks = [
        "catppuccin"
        "rimless"
      ];
    })
    (mint-themes.overrideAttrs (oldAttrs: {
      # patch accent color to catppuccin maroon
      postInstall = (oldAttrs.postInstall or "") + ''
        cp -r "$out/share/themes/Mint-Y-Red" "$out/share/themes/Mint-Y-Maroon"
        function subcolor {
          substituteInPlace "$out/share/themes/Mint-Y-Maroon/$1" --replace "#e82127" "#e64553"
        }

        subcolor "cinnamon/cinnamon.css"
        subcolor "gtk-2.0/gtkrc"
        subcolor "gtk-3.0/gtk.css"
        subcolor "gtk-3.0/gtk-dark.css"
        subcolor "gtk-4.0/gtk.css"
        subcolor "gtk-4.0/gtk-dark.css"
      '';
    }))
  ]);
  environment.variables = {
    # add libraries such as libgtop so imports.gi/cinnamon spices can find them
    GI_TYPELIB_PATH = "/run/current-system/sw/lib/girepository-1.0";
  };

  ### nixos compat stuff
  # nix-ld because I'm lazy and it works
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [ # taken from u/henry_tennenbaum, who took it from someone else
      alsa-lib at-spi2-atk at-spi2-core atk cairo 
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
