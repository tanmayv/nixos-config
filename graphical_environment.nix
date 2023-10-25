{ config, pkgs, ... }:


{
 
  /*
  nixpkgs.overlays = [ 
    
    #gnome vrr patch *doesn't work on unstable channel*
    
    (self: super: {
      gnome = super.gnome.overrideScope' (pself: psuper: {
        
        mutter = psuper.mutter.overrideAttrs (oldAttrs: {
          patches = (oldAttrs.patches or [ ]) ++ [

            #dynamic triple/double buffer
            (super.fetchpatch {
              url = "https://aur.archlinux.org/cgit/aur.git/plain/mr1441.patch?h=mutter-dynamic-buffering&id=d3a8bdd1b7bad6a7f3820f143fb8384dcd1ac497";
              hash = "sha256-VHL+++nkbYOsgrlrj3aJHDcOjs/Wkma0+mJzbLsjmrY=";
            })
            (super.fetchpatch {
              url = "https://gitlab.gnome.org/GNOME/mutter/-/merge_requests/3304.patch";
              hash = "sha256-3h8VwEkGYxG2BnOc6Je/TXpSaDGppbhYJ7/aOTjo8uA=";
            })




            

          ];
        });

        
        
        gnome-control-center = psuper.gnome-control-center.overrideAttrs (oldAttrs: {
          patches = oldAttrs.patches ++ [

            #varaiable refresh rate in settings
            
            (super.fetchpatch {
              url = "https://aur.archlinux.org/cgit/aur.git/plain/734.patch?h=gnome-control-center-vrr";
              hash = "sha256-8FGPLTDWbPjY1ulVxJnWORmeCdWKvNKcv9OqOQ1k/bE=";
            })
            
          
          ];
        });
        

      });
    })


  
  ];
  
  */

  #gnome
  services.xserver.enable = true;
  #services.xserver.desktopManager.gnome.enable = true;
  services.xserver.displayManager.gdm.enable = true;



  programs.hyprland.enable = true;
  programs.hyprland.xwayland.enable = true;
  programs.hyprland.enableNvidiaPatches = true;


 

  xdg = {
  autostart.enable = true;
  portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal
        pkgs.xdg-desktop-portal-gtk
      ];
    };
  };
  
  

}
