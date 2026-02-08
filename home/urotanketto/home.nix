{ config, pkgs, ... }:

{
  home.username = "urotanketto";
  home.homeDirectory = "/home/urotanketto";

  home.stateVersion = "25.11";

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "urotanketto";
        email = "197749865+urotanketto@users.noreply.github.com";
      };

      init.defaultBranch = "main";
      pull.rebase = false;
      core.editor = "nvim";
      color.ui = "auto";
    };

  };

  programs.zsh.enable = true;
  programs.fzf.enable = true;

  programs.tmux = {
    enable = true;
    terminal = "screen-256color";
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  xdg.configFile."nvim/init.lua".text = ''
    -- Basic options
    vim.g.mapleader = " "

    vim.opt.number = true
    vim.opt.signcolumn = "yes"
    -- Enable truecolor only on terminals that can handle it well
    local term = vim.env.TERM or ""
    local colorterm = vim.env.COLORTERM or ""

    if term ~= "linux" and (colorterm ~= "" or term:find("256color")) then
      vim.opt.termguicolors = true
    else
      vim.opt.termguicolors = false
    end

    vim.opt.expandtab = true
    vim.opt.shiftwidth = 2
    vim.opt.tabstop = 2

    vim.opt.ignorecase = true
    vim.opt.smartcase = true
'';

  home.packages = with pkgs; [
    ripgrep fd jq tree
    pciutils usbutils
    lsof strace htop
    dnsutils mtr traceroute ethtool
    unzip zip xz
    lm_sensors
    gh
    gcc binutils

    # --- Go ---
    go
    gopls
    gotools
    golangci-lint
    delve

    # --- Rust ---
    rustc
    cargo
    rust-analyzer
    cargo-edit
    cargo-watch

    # --- Haskell ---
    ghc
    cabal-install
    haskell-language-server
    hlint
    ormolu
  ];
}

