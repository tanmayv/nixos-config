i3 setup



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