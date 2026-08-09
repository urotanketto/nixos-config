{ config, pkgs, ... }:

{
  imports = [
    ./modules/core.nix
    ./modules/cli.nix
    ./modules/gui.nix
    ./modules/ghostty.nix
    ./modules/hyprland.nix
    ./modules/waybar.nix
    ./modules/ime.nix
    ./modules/nvim.nix
    ./modules/tmux.nix
    ./modules/firefox.nix
    ./modules/vimium.nix
    ./modules/niri.nix
  ];
}

