{ config, pkgs, ... }:

{
  home.username = "pujan";
  home.homeDirectory = "/home/pujan";

  home.stateVersion = "25.11"; 

  programs.home-manager.enable = true;
}
