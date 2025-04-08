# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./nvidia.nix
    ./pkgs.nix
    ./keyd.nix
  ];

  # flakes!
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable networking
  networking = {
    networkmanager.enable = true;
    hostName = "dregsdesk15"; # Define your hostname.
    wireless.enable = false; # Enables wireless support via wpa_supplicant.
    nameservers = [
      "9.9.9.9"
      "1.1.1.1"
    ];
    networkmanager.dns = "none";
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;

  # noatime
  fileSystems."/".options = [ "noatime" ];
  fileSystems."/home".options = [ "noatime" ];
  fileSystems."/boot".options = [ "noatime" ];

  # Enable magic sysrq key
  boot.kernel.sysctl = {
    "kernel.sysrq" = 246;

    "vm.swappiness" = 180; # zram optimisations from arch/pop! zram wiki page
    "vm.watermark_boost_factor" = 0;
    "vm.watermark_scale_factor" = 125;
    "vm.page-cluster" = 0;
  };

  # zram!!
  zramSwap = {
    enable = true;
    algorithm = "lz4";
    memoryPercent = 100;
  };

  # set cpu performance setting
  powerManagement.cpuFreqGovernor = "performance";

  # copy wallpaper to root so lightdm-gtk-greeter can find it
  # this requires `sudo rm /wallpaper.png` and reboot to refresh
  systemd.tmpfiles.settings.wallpaper."/wallpaper.png"."C+" = {
    group = "root";
    user = "root";
    age = "-";
    argument = "/home/jason/dotfiles/extras/wallpaper.png";
  };

  # Set your time zone.
  time.timeZone = "America/Toronto";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  ## Enable the KDE Plasma Desktop Environment.
  #services.displayManager.sddm.enable = true;
  #services.desktopManager.plasma6.enable = true;

  # Enable Xfce and LightDM.
  services.xserver.displayManager.lightdm = {
    enable = true;
    greeters.gtk = {
      extraConfig = ''
        [greeter]
        background = /wallpaper.png
      '';
      clock-format = "%H:%M:%S";
    };

  };
  services.xserver.desktopManager.xfce.enable = true;

  # Enable CUPS to print documents. Also find printers.
  services.printing = {
    enable = true;
    browsing = true;
    browsedConf = ''
      BrowseDNSSDSubTypes _cups,_print
      BrowseLocalProtocols all
      BrowseRemoteProtocols all
      CreateIPPPrinterQueues All

      BrowseProtocols all
    '';
  };
  services.avahi = {
    enable = true;
    nssmdns4 = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jason = {
    isNormalUser = true;
    description = "Jason Fan";
    extraGroups = [
      "networkmanager"
      "wheel"
      "audio"
    ];
    hashedPassword = "$y$j9T$C247i/8BbAzdZ/NuKQ1Nm/$6RTfpsMyWSlmhVKCXeLrATYWBhtBVny.7kTjz.GnR95";
  };
  #users.users.test = {
  #  isNormalUser = true;
  #  description = "test";
  #  extraGroups = [
  #    "networkmanager"
  #    "wheel"
  #  ];
  #  password = "test";
  #};

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
