{ pkgs, mnw }:

let
  args = { inherit pkgs; };
in
mnw.lib.wrap pkgs {
  appName = "nvim";
  neovim = pkgs.neovim.unwrapped;

  luaFiles = [
    ./init.lua
  ];

  plugins = {
    startAttrs = {
      inherit (pkgs.vimPlugins) rainbow-delimiters-nvim tokyonight-nvim;
    };
    start = [
      (pkgs.vimPlugins.nvim-treesitter.withPlugins (p: with p; [ lua nix ]))
    ];
    dev.config = {
      pure = ./nvim;
      impure = "/home/emanresu/Documents/projects/temp/nvim"; # Absolute path needed
    };
  };
}
