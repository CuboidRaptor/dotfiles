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
  };

  ## fuck me does this cause problems
  ## (breaks podman, breaks distrobox, takes 45645,6,456 morbillion hours to compile)
  #virtualisation.virtualbox.host = {
  #  enable = true;
  #  enableExtensionPack = true;
  #};
  virtualisation.podman = {
    enable = true;
    dockerCompat= true;
  };

  services.gvfs.enable = true; # for trash-cli

  # sublime text 4/gh desktop and some other packages need it
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
    with pkgs; [
      jdk # programming languages stuff
      sublime4
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
      gh
      git
      lf
      imagemagick
      http-server
      xclip
      glib
      fuse
      fzf
      ripgrep
      fd

      gparted # apps
      firefox-devedition-bin
      vesktop
      speedcrunch
      anki
      flameshot
      vlc
      thunderbird
      wineWowPackages.stable
      winetricks
      vscodium-fhs
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
      parsec-bin
      wezterm
      librewolf
      dl-librescore
      kdePackages.okular
      kdePackages.kolourpaint
      gimp
      gpick
      dconf-editor
      distrobox
      audacity

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

      xarchiver  # xfce stuff
      seahorse
      xfce.xfce4-whiskermenu-plugin
      xfce.xfce4-docklike-plugin
      xfce.xfce4-systemload-plugin
      xfce.xfce4-xkb-plugin
      rose-pine-gtk-theme
      rose-pine-icon-theme
      rose-pine-cursor
    ];

  programs.thunar.plugins = [
    pkgs.xfce.thunar-archive-plugin
  ];

  nixpkgs.overlays = [
    (self: super: {
      xarchiver = super.xarchiver.overrideAttrs (old: {
        postInstall = ''
          rm -rf $out/libexec
        '';
      });

      xfce = super.xfce.overrideScope (xself: xsuper: {
        thunar-archive-plugin = xsuper.thunar-archive-plugin.overrideAttrs (old: {
          postInstall = ''
            cp ${super.xarchiver}/libexec/thunar-archive-plugin/* $out/libexec/thunar-archive-plugin/
          '';
        });
      });
    })
  ];

  environment.variables = {
    JAVA_8_HOME = "${pkgs.jdk8}/lib/openjdk";
    JAVA_17_HOME = "${pkgs.jdk17}/lib/openjdk";
    JAVA_21_HOME = "${pkgs.jdk21}/lib/openjdk";
  };
}