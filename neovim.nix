{ inputs, pkgs, ... }:

{
  imports = [ inputs.nixvim.nixosModules.nixvim ];
  
  programs.nixvim = {
    enable = true;
    clipboard.providers.wl-copy.enable = true;
    opts = {
      number = true; # Show line numbers
      shiftwidth = 4; # Tab width should be 2 spaces
      relativenumber = true; # Show relative line numbers
    };

    plugins = {
	  airline.enable = true;
	  cmp.enable = true;
	  cmp_luasnip.enable = true;
	  cmp-nvim-lsp.enable = true;
	  cmp-buffer.enable = true;
	  cmp-path.enable = true;
	  cmp-cmdline.enable = true;
	  gitsigns.enable = true;  
	  oil.enable = true;
	  # nvim-tree.enable = true;
	  telescope.enable = true;
	  codeium-vim.enable = true;
          treesitter = {
	          enable = true;
		  gccPackage = pkgs.gcc;
          };

	  lsp = {
	    enable = true;
	    servers = {
		astro.enable = true;
		html.enable = true;
		pyright.enable = true;
		tsserver.enable = true;
		#rust-analyzer.enable = true;
		nil-ls.enable = true;
		clangd.enable = true;
		java-language-server.enable = true;
	    };

	  };

    };



    highlight = {
      MacchiatoRed.fg = "#ed8796";
    };

    extraConfigLua = builtins.readFile ./neovim-config.lua;
    };

}
