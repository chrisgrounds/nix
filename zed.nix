{ pkgs, ... }: {
  programs.zed-editor = {
    enable = true;
    extraPackages = [ pkgs.nixd pkgs.nil ];
    extensions = [ "nix" "toml" "rust" "catppuccin" "catppuccin-icons" ];
    userSettings = {
      theme = "Catppuccin Mocha";
      ui_font_size = 22;
      buffer_font_size = 20;
      hour_format = "hour24";
      tab_bar = { show = true; };
      tabs = { show_diagnostics = "errors"; };
      indent_guides = {
        enabled = true;
        coloring = "indent_aware";
      };
      inlay_hints = { enabled = true; };
      lsp = {
        rust-analyzer = { binary = { path_lookup = true; }; };

        nix = { binary = { path_lookup = true; }; };
      };
      minimap = {
        show = "always";
      };
    };
  };
}
