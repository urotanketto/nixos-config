{ config, pkgs, ... }:

{
  home.username = "urotanketto";
  home.homeDirectory = "/home/urotanketto";

  home.stateVersion = "25.11";

  programs.home-manager.enable = true;

  programs.git.enable = true;
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
  ];
}

