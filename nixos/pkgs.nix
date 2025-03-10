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
    starship.enable = true;
  };

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
      jdk
      sublime4
      gcc
      (makeNixLDWrapper python313Full)
      nodejs
      clang-tools
      clang
      nixd

      xfce.xfce4-whiskermenu-plugin
      xfce.xfce4-docklike-plugin
      xfce.xfce4-systemload-plugin
      xfce.xfce4-xkb-plugin

      lf
      github-desktop
      gparted
      firefox-devedition-bin
      vesktop
      speedcrunch
      anki
      flameshot
      vlc
      thunderbird
      kdePackages.kwalletmanager
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
      fzf
      ripgrep
      fd
      dl-librescore

      zip
      unzip
      curl
      eza
      bat
      fastfetch
      htop
      ##neovim # (installed through nvim.nix)
      micro
      gh
      git
      imagemagick
      hollywood
      http-server
      xclip
      glib

      lutris
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
    ];

  fonts.packages = with pkgs; [
    cascadia-code
  ];

  environment.variables = {
    JAVA_8_HOME = "${pkgs.jdk8}/lib/openjdk";
    JAVA_17_HOME = "${pkgs.jdk17}/lib/openjdk";
    JAVA_21_HOME = "${pkgs.jdk21}/lib/openjdk";
  };
}