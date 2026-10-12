 { pkgs, ... }:

{
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

  programs.zsh = {
    enable = true;

    initContent = ''
      # Use a simple Starship prompt on the Linux virtual console.
      if [[ "$TERM" == "linux" ]]; then
        export STARSHIP_CONFIG="$HOME/.config/starship-tty.toml"
      fi

      # tmux: attach-or-create main session
      t() { tmux new-session -A -s main; }
    '';
  };

  programs.fzf.enable = true;

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  xdg.configFile."starship.toml".source = ../starship/starship.toml;
  xdg.configFile."starship-tty.toml".source = ../starship/starship-tty.toml;

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

