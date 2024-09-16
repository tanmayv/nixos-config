{config, pkgs, ...}:
let
  kernel_patch = fetchGit {
    url = "https://gitlab.com/asus-linux/fedora-kernel";
  };
in 
{ 


    boot = {
	kernelPackages = pkgs.linuxPackages_latest;
	kernelPatches = map (patch: {inherit patch;}) [
	    "${kernel_patch}/asus-patch-series.patch"
	];
	kernelParams = [  "amdgpu.dcdebugmask=0x10" ];
	    
	kernel.sysctl."vm.max_map_count" = 2147483642;
	
	blacklistedKernelModules = [ "nouveau" ];
    };

}


