#!/bin/sh
killall .waybar-wrapped

# ----------------------------------------------------- 
# Loading the configuration based on the username
# ----------------------------------------------------- 
if [[ $USER = "samuel" ]]
then
    waybar -c ~/Git/dotfiles/waybar/myconfig & -s ~/Git/dotfiles/waybar/style.css  
else
    waybar &
fi 
