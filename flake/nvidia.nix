{ config, pkgs, inputs, ... }:

{
    #love nvidia fr
    boot.blacklistedKernelModules = [ "nouveau" ];
    boot.kernelModules = [
        "nvidis_uvm"
        "nvidia_modeset"
        "nvidia_drm"
        "nvidia"
        "glaxnimate"
    ];
    nixpkgs.config.nvidia.acceptLicense = true;
    services.xserver.videoDrivers = [ "nvidia" ];
    environment.variables = {
        GBM_BACKEND = "nvidia-drm";
        LIBVA_DRIVER_NAME = "nvidia";
        __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    };
    environment.systemPackages = with pkgs; [
        vulkan-loader
        vulkan-validation-layers
        vulkan-tools
    ];
    hardware = {
        nvidia = {
            modesetting.enable = true;
            powerManagement.enable = true;
            nvidiaSettings = true;
            open = false;
            package = config.boot.kernelPackages.nvidiaPackages.latest;
        };
        graphics = {
            enable = true;
        };
        opengl = {
            enable = true;
            driSupport32Bit = true;
            extraPackages = with pkgs; [
                nvidia-vaapi-driver
                vaapiVdpau
                libvdpau-va-gl
            ];
        };
    };
}