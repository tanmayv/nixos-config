










boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [  "amdgpu.dcdebugmask=0x10" ];
        
    kernel.sysctl."vm.max_map_count" = 2147483642;
    
    blacklistedKernelModules = [ "nouveau" ];
};

