{ pkgs, ... }: {
  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;

    opts = {
      number = true;
      shiftwidth = 2;
    };

    autoCmd = [{
      event = [ "VimEnter" ];
      pattern = [ "*" ];
      command = "if &diff | colorscheme blue | endif";
    }];

    colorschemes.catppuccin.enable = true;

    plugins.lsp = {
      enable = true;
      servers = { nixd.enable = true; };
    };

    plugins.conform-nvim = {
      enable = true;
      settings.formatters_by_ft.nix = [ "nixfmt" ];
      settings.format_on_save = {
        # Format on save in all files
        lspFallback = true;
        timeoutMs = 500;
      };
    };

    plugins.treesitter = {
      enable = true;
      grammarPackages = with pkgs.vimPlugins.nvim-treesitter-parsers; [ nix ];
    };
  };
}
