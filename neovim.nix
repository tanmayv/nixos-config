{inputs, pkgs, ...}:

{
	imports = [inputs.nixvim.nixosModules.nixvim];
	
	programs.nixvim = {
	    enable = true;
	    plugins.lightline.enable = true;
	};

}
