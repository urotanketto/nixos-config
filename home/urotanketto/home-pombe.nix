{ ... }:

{
  imports = [
    ./modules/cli.nix
    ./modules/nvim.nix
  ];

  home.username = "urotanketto";
  home.homeDirectory = "/home/urotanketto";

  home.stateVersion = "25.11";
}
