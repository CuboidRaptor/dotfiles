{ config, pkgs, inputs, ... }:

{
    #love nvidia fr
    nixpkgs.config.nvidia.acceptLicense = true;
    services.xserver.videoDrivers = [ "nvidia" ];
    hardware = {
        nvidia = {
            modesetting.enable = true;
            powerManagement.enable = true;
            powerManagement.finegrained = false;
            nvidiaSettings = true;
            open = false;
            package = config.boot.kernelPackages.nvidiaPackages.stable;
        };
        graphics = {
            enable = true;
            enable32Bit = true;
        };
    };
    environment.systemPackages = with pkgs; [ vulkan-tools ];
    environment.variables = { WEBKIT_DISABLE_DMABUF_RENDERER = 1; };
}