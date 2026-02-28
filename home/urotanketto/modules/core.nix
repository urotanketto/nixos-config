{ config, pkgs, ... }:

{
  home.username = "urotanketto";
  home.homeDirectory = "/home/urotanketto";

  home.stateVersion = "25.11";

  programs.home-manager.enable = true;
}

