{ pkgs, ... }:
{
  programs.zed-editor = {
    enable = true;
    extraPackages = with pkgs; [
      nixd
      nil
    ];
    extensions = [
      "nix"
      "toml"
      "rust"
      "catppuccin"
      "catppuccin-icons"
    ];
    userSettings = {
      theme = "Catppuccin Mocha";
      icon_theme = "Catppuccin Mocha";
      ui_font_size = 22;
      buffer_font_size = 20;
      hour_format = "hour24";
      tab_bar = {
        show = true;
      };
      tabs = {
        show_diagnostics = "errors";
      };
      indent_guides = {
        enabled = true;
        coloring = "indent_aware";
      };
      inlay_hints = {
        enabled = true;
      };
      lsp = {
        rust-analyzer = {
          binary = {
            path_lookup = true;
          };
        };
        nix = {
          binary = {
            path_lookup = true;
          };
        };
        nil = {
          initialization_options = {
            formatting.command = [ "nixfmt" ];
          };
        };
      };
      minimap = {
        show = "always";
      };
    };
  };
}
