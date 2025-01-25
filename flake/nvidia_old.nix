{ config, pkgs, inputs, ... }:

{
  #love nvidia fr
  #boot.blacklistedKernelModules = [ "nouveau" ];
  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
  };
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [
    "nvidia-drm.modeset=1"
    "nvidia-drm.fbdev=1"
  ];

  hardware.nvidia = {
    powerManagement.enable = true;
    powerManagement.finegrained = false;

    open = false;

    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.beta;

    prime = {
      reverseSync.enable = false;
      offload.enable = true;

      nvidiaBusId = "PCI:1:0:0";
      amdgpuBusId = "PCI:4:0:0";
    };
  };

  nixpkgs = {
      config = {
        allowUnfree = true;
        #pulseaudio = true;
        nvidia.acceptLicense = true;
        packageOverrides = pkgs: { inherit (pkgs) linuxPackages_latest nvidia_x11; };
      };
    };

  services.xserver.videoDrivers = [ "nvidia" ];
}