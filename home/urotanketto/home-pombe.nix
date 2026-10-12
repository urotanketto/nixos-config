{ ... }:

{
  imports = [
    ./modules/cli.nix
    ./modules/nvim.nix
    ./modules/tmux.nix
  ];

  services.ssh-agent.enable = true;

  home.username = "urotanketto";
  home.homeDirectory = "/home/urotanketto";

  home.stateVersion = "25.11";
}
