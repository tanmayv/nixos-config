{inputs, pkgs, ...}:

{
    imports = [inputs.nixvim.nixosModules.nixvim];
    programs.nixvim = {
	enable = true;
	plugins.lightline.enable = true;
        clipboard.providers.wl-copy.enable = true;
	
     

	options = {
	   number = true;         # Show line numbers
	   shiftwidth = 4;        # Tab width should be 2 spaces

        };


	plugins = {
	  
	  gitsigns.enable = true;  

	  nvim-tree.enable = true;

	  telescope = {
		  enable = true;

	  };

          treesitter = {
	          enable = true;
		  gccPackage = pkgs.gcc;
          };
	
	  codeium-vim.enable = true;
	

	  lsp = {
	    enable = true;
	    servers = {
		astro.enable = true;
		html.enable = true;
		pyright.enable = true;
		tsserver.enable = true;
		#rust-analyzer.enable = true;
		nil_ls.enable = true;
	    };

	  };

        };


        highlight = {
	   MacchiatoRed.fg = "#ed8796";
	};
	
	extraConfigLua = ''
	  vim.cmd(':NvimTreeOpen')
	'';



    };

}
