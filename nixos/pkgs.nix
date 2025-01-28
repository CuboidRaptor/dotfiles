{ pkgs, ... }:

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

  environment.systemPackages = with pkgs; [
    jdk8
    jdk17
    jdk21
    python313Full
    nodejs_23
    nodejs_18
    sublime4

    xmousepasteblock
    github-desktop
    gparted
    firefox-devedition-bin
    vesktop
    speedcrunch
    anki-bin
    flameshot
    vlc
    thunderbird-bin
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
    kdePackages.kate
    remmina
    pavucontrol
    parsec-bin

    eza
    bat
    fastfetch
    htop
    ##neovim # (installed through nvim.nix)
    micro
    git
    imagemagick
    hollywood
    http-server

    lutris
    prismlauncher
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