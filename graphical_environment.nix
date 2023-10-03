{ config, pkgs, ... }:


{
 
  
  nixpkgs.overlays = [ 
    
    #gnome vrr patch still not working :|
    (self: super: {
      gnome = super.gnome.overrideScope' (pself: psuper: {
        /*  
        mutter = psuper.mutter.overrideAttrs (oldAttrs: {
          patches = (oldAttrs.patches or [ ]) ++ [
            (super.fetchpatch {
              url = "https://aur.archlinux.org/cgit/aur.git/plain/vrr.patch?h=mutter-vrr";
              hash = "sha256-tTu4IwU6Fjff1bgOmS2ar93Uxhaw0BWB1ZLjOcLaL/g=";
            })
          ];
        });
        */
        gnome-control-center = psuper.gnome-control-center.overrideAttrs (oldAttrs: {
          patches = oldAttrs.patches ++ [
            (super.fetchpatch {
              url = "https://aur.archlinux.org/cgit/aur.git/plain/734.patch?h=gnome-control-center-vrr";
              hash = "sha256-8FGPLTDWbPjY1ulVxJnWORmeCdWKvNKcv9OqOQ1k/bE=";
            })
          ];
        });
        
      });
    })


  
  ];
  


  #gnome
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  
  
 

  

}
