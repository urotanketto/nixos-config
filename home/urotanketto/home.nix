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

