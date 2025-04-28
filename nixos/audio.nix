{
  config,
  lib,
  pkgs,
  inputs,
  winepinnedpkgs,
  ...
}:

{
  ### decent chunk of this config is just a customised (stolen) version of musnix
  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # packages
  environment.systemPackages = with pkgs; [
    reaper
    (yabridge.override {
      wine = winepinnedpkgs.wineWowPackages.staging;
    })
    yabridgectl
    (pkgs.callPackage ./tx16wx.nix { })
  ];

  # set memlock and other stuff for realtime with vst plugins
  security.pam.loginLimits = [
    {
      domain = "@audio";
      item = "memlock";
      type = "-";
      value = "unlimited";
    }
    {
      domain = "@audio";
      item = "rtprio";
      type = "-";
      value = "99";
    }
    {
      domain = "@audio";
      item = "nofile";
      type = "soft";
      value = "99999";
    }
    {
      domain = "@audio";
      item = "nofile";
      type = "hard";
      value = "524288"; # higher limit for esync as well as audio
    }
  ];
  # set more rules for less latency
  services.udev = {
    extraRules = ''
      KERNEL=="rtc0", GROUP="audio"
      KERNEL=="hpet", GROUP="audio"
      DEVPATH=="/devices/virtual/misc/cpu_dma_latency", OWNER="root", GROUP="audio", MODE="0660"
    '';
  };
  # allow realtime irqs or whatever
  boot.kernelParams = [ "threadirqs" ];
  services.das_watchdog.enable = true; # prevent realtime stuff from hanging
  # add some kernel modules
  boot.kernelModules = [
    "snd-seq"
    "snd-rawmidi"
  ];
  # set some variables for paths of plugins
  environment.sessionVariables =
    let
      makePluginPath =
        format:
        "$HOME/.${format}:"
        + (lib.makeSearchPath format [
          "$HOME/.nix-profile/lib"
          "/run/current-system/sw/lib"
          "/etc/profiles/per-user/$USER/lib"
        ]);
    in
    {
      CLAP_PATH = lib.mkDefault (makePluginPath "clap");
      DSSI_PATH = lib.mkDefault (makePluginPath "dssi");
      LADSPA_PATH = lib.mkDefault (makePluginPath "ladspa");
      LV2_PATH = lib.mkDefault (makePluginPath "lv2");
      LXVST_PATH = lib.mkDefault (makePluginPath "lxvst");
      VST3_PATH = lib.mkDefault (makePluginPath "vst3");
      VST_PATH = lib.mkDefault (makePluginPath "vst");
    };
}
