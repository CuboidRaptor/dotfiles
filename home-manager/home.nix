{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "jason";
  home.homeDirectory = "/home/jason";

  nixpkgs.config.allowUnfree = true;

  imports = [
    ./nvidia.nix
  ];

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.

  # generic linux support for stuff, e.g. gpu
  targets.genericLinux.enable = true;

  fonts.fontconfig.enable = true;

  programs.nh = {
    enable = true;
    homeFlake = "path:///home/jason/dotfiles/home-manager";
    clean = {
      enable = true;
      extraArgs = "--keep-since 15d --keep 3 --optimise";
    };
  };

  home.packages = with pkgs; [
    nixfmt
    dash

    # cmdline stuff
    git
    gh
    zsh
    tmux
    neovim
    eza
    fzf
    fd
    xsel
    trash-cli
    inotify-tools # syncthing-watcher dep
    tree-sitter # nvim dep
    tldr
    winetricks
    yt-dlp
    kanata
    gpick

    ckan
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
