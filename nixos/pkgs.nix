{
  config,
  pkgs,
  inputs,
  ...
}:

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

  xdg.portal = {
    # for flatpak
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "gtk";
  };
  services = {
    gvfs.enable = true; # for trash-cli
    flatpak = {
      enable = true;
      uninstallUnmanaged = true;
      packages = [
        # requires nix-flatpak flake
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

  # cursed hack to fix firefox dev
  environment.sessionVariables = {
    MOZ_APP_REMOTINGNAME = "firefox-devedition";
  };
  environment.systemPackages =
    let
      # NixLDWrapper code from bvngee https://bvngee.com/blogs/using-python-virtualenvs-in-nixos
      # Some dynamic executables are unpatched but are loaded by patched nixpkgs
      # executables, and therefore never pick up NIX_LD_LIBRARY_PATH. For
      # example, interpreters that use dynamically linked libraries, like python3
      # libraries run by nixpkgs' python. This wraps the interpreter for ease of
      # use with those executables. WARNING: Using LD_LIBRARY_PATH like this can
      # override some of the program's dylib links in the nix store; this should
      # be generally ok though
      makeNixLDWrapper =
        program:
        (pkgs.runCommand "${program.pname}-nix-ld-wrapped" { } ''
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
      nixfmt-rfc-style
      bash-language-server
      dash

      zip # dev stuff/deps
      unzip
      curl
      libgtop
      eza
      bat
      fastfetch
      btop
      tmuxp
      libnotify
      tree
      gh
      git
      tldr
      ffmpeg
      numlockx
      trash-cli
      imagemagick
      p7zip
      xmousepasteblock
      http-server
      xclip
      fzf
      ripgrep
      fd

      gparted # apps
      firefox-devedition
      ungoogled-chromium
      sublime4
      vesktop
      speedcrunch
      anki
      obsidian
      flameshot
      vlc
      obs-studio
      wineWowPackages.staging
      winetricks
      (vivaldi.overrideAttrs (oldAttrs: {
        dontWrapQtApps = false;
        dontPatchELF = true;
        nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [ pkgs.kdePackages.wrapQtAppsHook ];
      }))
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
      musescore
      audacity

      (prismlauncher.override {
        # games and stuff
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
      (mint-themes.overrideAttrs (oldAttrs: {
        # patch accent color to catppuccin mauve
        postInstall =
          (oldAttrs.postInstall or "")
          + ''
            cp -r "$out/share/themes/Mint-Y-Red" "$out/share/themes/Mint-Y-Maroon-Catppuccin"
            cp -r "$out/share/themes/Mint-Y-Dark-Red" "$out/share/themes/Mint-Y-Dark-Maroon-Catppuccin"

            function subcolor {
              substituteInPlace "$out/share/themes/Mint-Y-Maroon-Catppuccin/$1" --replace "#e82127" "#e64553"
              substituteInPlace "$out/share/themes/Mint-Y-Maroon-Catppuccin/$1" --replace "#E82127" "#E64553"
              substituteInPlace "$out/share/themes/Mint-Y-Maroon-Catppuccin/$1" --replace "rgba(232, 33, 39" "rgba(230, 69, 83"

              substituteInPlace "$out/share/themes/Mint-Y-Dark-Maroon-Catppuccin/$1" --replace "#e82127" "#eba0ac"
              substituteInPlace "$out/share/themes/Mint-Y-Dark-Maroon-Catppuccin/$1" --replace "#E82127" "#EBA0AC"
              substituteInPlace "$out/share/themes/Mint-Y-Dark-Maroon-Catppuccin/$1" --replace "rgba(232, 33, 39" "rgba(235, 160, 172"
            }

            subcolor "cinnamon/cinnamon.css"
            subcolor "gtk-2.0/apps.rc"
            subcolor "gtk-2.0/gtkrc"
            subcolor "gtk-2.0/main.rc"
            subcolor "gtk-2.0/menubar-toolbar.rc"
            subcolor "gtk-2.0/menubar-toolbar-dark.rc"
            subcolor "gtk-2.0/panel.rc"
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
  # envfs it also makes my life easier
  services.envfs.enable = true;
  # screwing with appimages to make them run
  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  # nix-ld because I'm lazy and it works
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      # taken from u/henry_tennenbaum, who took it from someone else
      alsa-lib
      at-spi2-atk
      at-spi2-core
      atk
      cairo
      cups
      curl
      dbus
      expat
      fontconfig
      freetype
      fuse3
      gdk-pixbuf
      glib
      gtk3
      icu
      libGL
      libappindicator-gtk3
      libdrm
      libglvnd
      libnotify
      libpulseaudio
      libunwind
      libusb1
      libuuid
      libxkbcommon
      libxml2
      mesa
      nspr
      nss
      openssl
      pango
      pipewire
      stdenv.cc.cc
      systemd
      vulkan-loader
      xorg.libX11
      xorg.libXScrnSaver
      xorg.libXcomposite
      xorg.libXcursor
      xorg.libXdamage
      xorg.libXext
      xorg.libXfixes
      xorg.libXi
      xorg.libXrandr
      xorg.libXrender
      xorg.libXtst
      xorg.libxcb
      xorg.libxkbfile
      xorg.libxshmfence
      zlib
    ];
  };
}
