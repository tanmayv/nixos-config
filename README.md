# nixos
minimal nix config for gnome wayland for G15 Zephyrus 2021

![image (1)](https://github.com/sjhaleprogrammer/nixos/assets/60676867/615ce50e-be6d-4de8-8a82-fe17dda4f041)



# Install Guide

Install nixos on your system at https://nixos.org/download gnome install  *i think minimal will would not tested*

run ```nix-shell -p git``` to get git 

give write permissions to nixos folder 
```chmod 777 /etc/nixos```

cd to nixos folder
```cd /etc/nixos```

run these to clone my config over
```git init```

```git remote add origin https://github.com/sjhaleprogrammer/nixos.git```

```git pull origin master```

finally run 
```sudo ./update.sh```