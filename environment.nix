{ config, pkgs, ... }:

{
  environment.shells = with pkgs; [ zsh bash dash ];
  environment.binsh = "${pkgs.dash}/bin/dash";
  programs.zsh.enable = true;
  system.activationScripts.linkBash = {
    text = ''
      ln -sf ${pkgs.bash}/bin/bash /bin/bash
    '';
  };

  environment.sessionVariables = rec {
    NIXOS_OZONE_WL = "1";
   
    XDG_CACHE_HOME  = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME   = "$HOME/.local/share";
    XDG_STATE_HOME  = "$HOME/.local/state";

    # Not officially in the specification
    XDG_BIN_HOME    = "$HOME/.local/bin";
    PATH = [ 
      "${XDG_BIN_HOME}"
    ];
  };
}
