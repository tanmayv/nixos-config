{ config, pkgs, inputs, ... }:

{


    home.username = "samuel";

    home.homeDirectory = "/home/samuel";

    home.stateVersion = "23.05";

    programs.home-manager.enable = true;


    programs.git = {
        enable = true;
        userName = "Samuel Hale";
        userEmail = "samworlds1231337@gmail.com";
    };

}