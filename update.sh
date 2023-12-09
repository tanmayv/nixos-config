#!/bin/bash

#update flake
nix flake update 


# Update NixOS channels and switch to the latest generation
#nix-channel --update
nixos-rebuild switch -j 1



#update dot files

user_home="/home/samuel"  

# Check if the .config directory exists
if [ -d "$user_home/.config" ]; then
    echo "The .config directory exists in $user_home"
else
    echo "The .config directory does not exist in $user_home"
    # Create the .config directory if it doesn't exist
    mkdir -p "$user_home/.config"
fi



echo "UPDATING DOTS ############################"

#Hyprland 
if [ -d "$user_home/.config/hypr" ]; then
    echo "The hypr directory exists within .config"
else
    echo "The hypr directory does not exist within .config"
    mkdir -p "$user_home/.config/hypr"
fi
cp -r /etc/nixos/dots/hyprland/* "$user_home/.config/hypr/"
echo "The hyprland directory has been updated in $user_home/.config/hypr"

#Waybar
if [ -d "$user_home/.config/waybar" ]; then
    echo "The waybar directory exists within .config"
else
    echo "The waybar directory does not exist within .config"
    mkdir -p "$user_home/.config/waybar"
fi
rm -rf $user_home/.config/waybar/*
cp -r /etc/nixos/dots/waybar/* "$user_home/.config/waybar/"
echo "The waybar directory has been updated in $user_home/.config/waybar"

#Starship
cp "/etc/nixos/dots/starship/starship.toml" "$user_home/.config/starship.toml"
echo "starship.toml has been updated in $user_home/.config/"


#Zsh
cp "/etc/nixos/dots/zsh/.zshrc" "$user_home/.zshrc"
echo ".zshrc has been updated in $user_home/"



#gtk-4.0
if [ -d "$user_home/.config/gtk-4.0" ]; then
    echo "The gtk-4.0 directory exists within .config"
else
    echo "The gtk-4.0 directory does not exist within .config"
    mkdir -p "$user_home/.config/gtk-4.0"
fi

rm -rf $user_home/.config/gtk-4.0/*
cp -r /etc/nixos/dots/gtk-4.0/* "$user_home/.config/gtk-4.0/"
echo "The gtk-4.0 directory has been updated in $user_home/.config/gtk-4.0"



echo "DONE ############################"



# Delete all old generations except the current and the previous one
nix-env --delete-generations old

# Collect garbage to free up disk space
nix-collect-garbage -d
