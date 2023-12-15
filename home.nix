{ config, pkgs, lib, ... }:

with lib.hm.gvariant;

{
 
  home.username = "samuel";
  home.homeDirectory = "/home/samuel";
  home.stateVersion = "23.05";
  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "Samuel Hale";
    userEmail = "samworlds1231337@gmail.com";
  };

  

  # starship - an customizable prompt for any shell
  programs.starship = {
    enable = true;
    settings = {

      add_newline = false;
      command_timeout = 1000;
      format = "$os$username$hostname$kubernetes$directory$git_branch$git_status";
      
      character = {
        success_symbol = "";
        error_symbol = "";

      };

      os = {
        format = "[$symbol](bold white) ";
        disabled = false;
      };

      os.symbols = {
        Windows = "";
        Arch = "󰣇";
        Ubuntu = "";
        Macos = "󰀵";
      };

      username = {
        style_user = "white bold";
        style_root = "black bold";
        format = "[$user]($style) ";
        disabled = false;
        show_always = true;
      };

      hostname = {
        ssh_only = false;
        format = "on [$hostname](bold yellow) ";
        disabled = false;
      };

      directory = {
        truncation_length = 1;
        truncation_symbol = "…/";
        home_symbol = "󰋜 ~";
        read_only_style = "197";
        read_only = "  ";
        format = "at [$path]($style)[$read_only]($read_only_style) ";

      };

      git_branch = {
        symbol = " ";
        format = "via [$symbol$branch]($style)";
        truncation_symbol = "…/";
        style = "bold green";
      };


      git_status = {
        format = "[$all_status$ahead_behind]($style) ";
        style = "bold green";
        conflicted = "🏳";
        up_to_date = "";
        untracked = " ";
        ahead = "⇡\${count}";
        diverged = "⇕⇡\${ahead_count}⇣\${behind_count}";
        behind = "⇣\${count}";
        stashed = " ";
        modified = " ";
        staged = "[++\($count\)](green)";
        renamed = "襁 ";
        deleted = " ";

      };

      kubernetes = {
        format = "via [󱃾 $context\($namespace\)](bold purple) ";
        disabled = false;
      };

      vagrant = {
        disabled = true;
      };  

      docker_context = {
        disabled = true;
      };

      helm = {
        disabled = true;
      };
      
      python = {
        disable = true;
      };

      nodejs = {
        disable = true;
      };

      ruby = {
        disable = true;
      };
      
      terraform = {
        disable = true;
      };


    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
    };

    initExtra = ''
      (cat /home/samuel/.cache/wal/sequences &)
      eval "$(starship init zsh)"
    '';
  };

  gtk = {
    enable = true;

    iconTheme = {
      name = "WhiteSur-dark";
      package = pkgs.whitesur-icon-theme;
    };

    theme = {
      name = "WhiteSur-Dark";
      package = pkgs.whitesur-gtk-theme;
    };

    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };

    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };

  home.sessionVariables.GTK_THEME = "WhiteSur-Dark";
  

  home.pointerCursor = 
    let 
      getFrom = url: hash: name: {
          gtk.enable = true;
          x11.enable = true;
          name = name;
          size = 26;
          package = 
            pkgs.runCommand "moveUp" {} ''
              mkdir -p $out/share/icons
              ln -s ${pkgs.fetchzip {
                url = url;
                hash = hash;
              }} $out/share/icons/${name}
          '';
        };
    in
      getFrom 
        "https://github.com/ful1e5/apple_cursor/releases/download/v2.0.0/macOS-Monterey.tar.gz"
        "sha256-MHmaZs56Q1NbjkecvfcG1zAW85BCZDn5kXmxqVzPc7M="
        "macOS-Monterey";
  

  dconf.settings = {
    "io/github/celluloid-player/celluloid" = {
      always-show-title-buttons = false;
      csd-enable = true;
    };

    "io/github/celluloid-player/celluloid/window-state" = {
      height = 779;
      loop-playlist = false;
      maximized = false;
      playlist-width = 323;
      show-playlist = false;
      volume = 1.0;
      width = 1223;
    };

    "org/gnome/Console" = {
      font-scale = 1.2000000000000002;
      last-window-size = mkTuple [ 1322 506 ];
      theme = "night";
    };

    "org/gnome/Snapshot" = {
      is-maximized = false;
      window-height = 640;
      window-width = 800;
    };

    "org/gnome/TextEditor" = {
      highlight-current-line = false;
      indent-style = "tab";
      last-save-directory = "file:///home/samuel/Documents";
      show-grid = false;
      show-line-numbers = true;
      show-map = false;
      show-right-margin = false;
      style-scheme = "Adwaita-dark";
      use-system-font = true;
    };

    "org/gnome/baobab/ui" = {
      is-maximized = false;
      window-size = mkTuple [ 1630 703 ];
    };

    "org/gnome/calculator" = {
      accuracy = 9;
      angle-units = "degrees";
      base = 10;
      button-mode = "basic";
      number-format = "automatic";
      show-thousands = false;
      show-zeroes = false;
      source-currency = "";
      source-units = "degree";
      target-currency = "";
      target-units = "radian";
      window-maximized = false;
      window-size = mkTuple [ 360 505 ];
      word-size = 64;
    };

    "org/gnome/control-center" = {
      last-panel = "display";
      window-state = mkTuple [ 1353 823 false ];
    };

    "org/gnome/desktop/app-folders" = {
      folder-children = [ "Utilities" "YaST" "aec422bf-76b3-4d84-97e6-7db381748f42" ];
    };

    "org/gnome/desktop/app-folders/folders/Utilities" = {
      apps = [ "gnome-abrt.desktop" "gnome-system-log.desktop" "nm-connection-editor.desktop" "org.gnome.baobab.desktop" "org.gnome.Connections.desktop" "org.gnome.DejaDup.desktop" "org.gnome.Dictionary.desktop" "org.gnome.DiskUtility.desktop" "org.gnome.eog.desktop" "org.gnome.Evince.desktop" "org.gnome.FileRoller.desktop" "org.gnome.fonts.desktop" "org.gnome.seahorse.Application.desktop" "org.gnome.tweaks.desktop" "org.gnome.Usage.desktop" "vinagre.desktop" ];
      categories = [ "X-GNOME-Utilities" ];
      name = "X-GNOME-Utilities.directory";
      translate = true;
    };

    "org/gnome/desktop/app-folders/folders/YaST" = {
      categories = [ "X-SuSE-YaST" ];
      name = "suse-yast.directory";
      translate = true;
    };

    "org/gnome/desktop/app-folders/folders/aec422bf-76b3-4d84-97e6-7db381748f42" = {
      apps = [ "net.rpcs3.RPCS3.desktop" "steam.desktop" "com.github.tchx84.Flatseal.desktop" "Steam Linux Runtime 3.0 (sniper).desktop" ];
      name = "Games";
    };

    "org/gnome/desktop/background" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri = "file:///home/samuel/Pictures/papers.co-vm89-flare-fire-red-abstract-pattern-blue-36-3840x2400-4k-wallpaper.jpg";
      picture-uri-dark = "file:///home/samuel/.config/background";
      primary-color = "#000000000000";
      secondary-color = "#000000000000";
    };

    "org/gnome/desktop/input-sources" = {
      sources = [ (mkTuple [ "xkb" "us" ]) ];
      xkb-options = [ "terminate:ctrl_alt_bksp" ];
    };

    "org/gnome/desktop/interface" = {
      clock-format = "12h";
      color-scheme = "prefer-dark";
      cursor-size = 26;
      cursor-theme = "macOS-Monterey";
      font-antialiasing = "grayscale";
      font-hinting = "slight";
      gtk-theme = "WhiteSur-Dark";
      icon-theme = "WhiteSur-dark";
      show-battery-percentage = true;
      text-scaling-factor = 1.0;
    };

    "org/gnome/desktop/notifications" = {
      application-children = [ "gnome-power-panel" "gnome-network-panel" "discord" "brave-browser" "codium" "org-gnome-console" "steam" "codium-url-handler" "org-gnome-nautilus" "org-gnome-settings" ];
    };

    "org/gnome/desktop/notifications/application/brave-browser" = {
      application-id = "brave-browser.desktop";
    };

    "org/gnome/desktop/notifications/application/codium-url-handler" = {
      application-id = "codium-url-handler.desktop";
    };

    "org/gnome/desktop/notifications/application/codium" = {
      application-id = "codium.desktop";
    };

    "org/gnome/desktop/notifications/application/discord" = {
      application-id = "discord.desktop";
    };

    "org/gnome/desktop/notifications/application/gnome-network-panel" = {
      application-id = "gnome-network-panel.desktop";
    };

    "org/gnome/desktop/notifications/application/gnome-power-panel" = {
      application-id = "gnome-power-panel.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-console" = {
      application-id = "org.gnome.Console.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-nautilus" = {
      application-id = "org.gnome.Nautilus.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-settings" = {
      application-id = "org.gnome.Settings.desktop";
    };

    "org/gnome/desktop/notifications/application/steam" = {
      application-id = "steam.desktop";
    };

    "org/gnome/desktop/peripherals/mouse" = {
      accel-profile = "flat";
      speed = 0.33834586466165417;
    };

    "org/gnome/desktop/peripherals/touchpad" = {
      click-method = "areas";
      tap-to-click = true;
      two-finger-scrolling-enabled = true;
    };

    "org/gnome/desktop/privacy" = {
      old-files-age = mkUint32 30;
      recent-files-max-age = -1;
    };

    "org/gnome/desktop/screensaver" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri = "file:///home/samuel/.local/share/backgrounds/2023-11-24-12-38-43-daniel-koponyas-Fi12iOBoZK4-unsplash.jpg";
      primary-color = "#000000000000";
      secondary-color = "#000000000000";
    };

    "org/gnome/desktop/session" = {
      idle-delay = mkUint32 0;
    };

    "org/gnome/desktop/sound" = {
      event-sounds = true;
      theme-name = "__custom";
    };

    "org/gnome/desktop/wm/keybindings" = {
      maximize = [ "<Control><Shift><Super>Up" ];
      unmaximize = [ "<Control><Shift><Super>Down" "<Alt>F5" ];
    };

    "org/gnome/desktop/wm/preferences" = {
      button-layout = "close,minimize,maximize:appmenu";
    };

    "org/gnome/epiphany" = {
      ask-for-default = false;
    };

    "org/gnome/epiphany/state" = {
      window-size = mkTuple [ 1234 768 ];
    };

    "org/gnome/evolution-data-server" = {
      migrated = true;
    };

    "org/gnome/file-roller/dialogs/extract" = {
      recreate-folders = true;
      skip-newer = false;
    };

    "org/gnome/file-roller/listing" = {
      list-mode = "as-folder";
      name-column-width = 250;
      show-path = false;
      sort-method = "name";
      sort-type = "ascending";
    };

    "org/gnome/file-roller/ui" = {
      sidebar-width = 200;
      window-height = 612;
      window-width = 1054;
    };

    "org/gnome/gnome-system-monitor" = {
      current-tab = "resources";
      maximized = false;
      network-total-in-bits = false;
      show-dependencies = false;
      show-whose-processes = "user";
      window-state = mkTuple [ 1379 706 45 29 ];
    };

    "org/gnome/gnome-system-monitor/disktreenew" = {
      col-6-visible = true;
      col-6-width = 0;
    };

    "org/gnome/gnome-system-monitor/openfilestree" = {
      sort-col = 0;
      sort-order = 0;
    };

    "org/gnome/gnome-system-monitor/proctree" = {
      col-0-visible = true;
      col-0-width = 670;
      col-1-visible = true;
      col-1-width = 100;
      col-12-visible = true;
      col-12-width = 68;
      col-23-visible = true;
      col-23-width = 234;
      col-24-visible = true;
      col-24-width = 129;
      col-8-visible = true;
      col-8-width = 90;
      columns-order = [ 0 1 2 3 4 6 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 ];
      sort-col = 8;
      sort-order = 0;
    };

    "org/gnome/mutter" = {
      dynamic-workspaces = true;
      edge-tiling = false;
    };

    "org/gnome/mutter/keybindings" = {
      toggle-tiled-left = [ "<Control><Shift><Super>Left" ];
      toggle-tiled-right = [ "<Control><Shift><Super>Right" ];
    };

    "org/gnome/nautilus/compression" = {
      default-compression-format = "zip";
    };

    "org/gnome/nautilus/list-view" = {
      default-zoom-level = "small";
    };

    "org/gnome/nautilus/preferences" = {
      default-folder-viewer = "list-view";
      migrated-gtk-settings = true;
      search-filter-time-type = "last_modified";
    };

    "org/gnome/nautilus/window-state" = {
      initial-size = mkTuple [ 1307 941 ];
      maximized = false;
    };

    "org/gnome/portal/filechooser/brave-browser" = {
      last-folder-path = "/home/samuel/Pictures";
    };

    "org/gnome/portal/filechooser/org/gnome/Settings" = {
      last-folder-path = "/home/samuel/Pictures";
    };

    "org/gnome/settings-daemon/plugins/color" = {
      night-light-enabled = false;
      night-light-temperature = mkUint32 4700;
    };

    "org/gnome/settings-daemon/plugins/power" = {
      sleep-inactive-ac-type = "nothing";
    };

    "org/gnome/shell" = {
      disable-user-extensions = false;
      disabled-extensions = [ "hidetopbar@mathieu.bidon.ca" "window-list@gnome-shell-extensions.gcampax.github.com" "windowsNavigator@gnome-shell-extensions.gcampax.github.com" "gSnap@micahosborne" "light-style@gnome-shell-extensions.gcampax.github.com" ];
      enabled-extensions = [ "supergfxctl-gex@asus-linux.org" "rounded-window-corners@yilozt" "workspace-indicator@gnome-shell-extensions.gcampax.github.com" "wintile@nowsci.com" "native-window-placement@gnome-shell-extensions.gcampax.github.com" "places-menu@gnome-shell-extensions.gcampax.github.com" "appindicatorsupport@rgcjonas.gmail.com" "compiz-alike-magic-lamp-effect@hermes83.github.com" "dash-to-dock@micxgx.gmail.com" "user-theme@gnome-shell-extensions.gcampax.github.com" "blur-my-shell@aunetx" ];
      favorite-apps = [ "org.gnome.Nautilus.desktop" "dev.vlinkz.NixSoftwareCenter.desktop" "nixos-manual.desktop" "brave-browser.desktop" "discord.desktop" "org.gnome.Console.desktop" "net.lutris.Lutris.desktop" "gnome-system-monitor.desktop" "virt-manager.desktop" "nvidia-settings.desktop" "org.gnome.Calculator.desktop" "org.gnome.baobab.desktop" "org.gnome.DiskUtility.desktop" "org.gnome.Extensions.desktop" "codium.desktop" "org.gnome.TextEditor.desktop" "org.gnome.tweaks.desktop" "org.gnome.Loupe.desktop" "org.gnome.FileRoller.desktop" "com.obsproject.Studio.desktop" "io.github.celluloid_player.Celluloid.desktop" "org.gnome.Snapshot.desktop" "rog-control-center.desktop" "org.gnome.Settings.desktop" ];
      last-selected-power-profile = "performance";
      welcome-dialog-last-shown-version = "44.5";
    };

    "org/gnome/shell/app-switcher" = {
      current-workspace-only = false;
    };

    "org/gnome/shell/extensions/blur-my-shell" = {
      debug = false;
      hacks-level = 3;
    };

    "org/gnome/shell/extensions/blur-my-shell/dash-to-dock" = {
      blur = false;
      customize = false;
    };

    "org/gnome/shell/extensions/dash-to-dock" = {
      autohide-in-fullscreen = true;
      background-opacity = 0.8;
      custom-theme-shrink = false;
      dash-max-icon-size = 32;
      dock-position = "BOTTOM";
      height-fraction = 1.0;
      hide-tooltip = false;
      intellihide = true;
      intellihide-mode = "ALL_WINDOWS";
      isolate-monitors = false;
      isolate-workspaces = false;
      preferred-monitor = -2;
      preferred-monitor-by-connector = "DP-2";
      preview-size-scale = 7.0e-2;
      scroll-to-focused-application = true;
      show-apps-at-top = true;
      show-favorites = true;
      show-mounts = false;
      show-mounts-only-mounted = true;
      show-running = true;
      show-show-apps-button = true;
      show-windows-preview = true;
      workspace-agnostic-urgent-windows = true;
    };

    "org/gnome/shell/extensions/gsnap" = {
      use-modifier = true;
    };

    "org/gnome/shell/extensions/hidetopbar" = {
      enable-active-window = false;
      enable-intellihide = true;
      hot-corner = true;
      keep-round-corners = false;
      mouse-sensitive = false;
      mouse-sensitive-fullscreen-window = true;
    };

    "org/gnome/shell/extensions/ncom/github/hermes83/compiz-alike-magic-lamp-effect" = {
      duration = 500.0;
      effect = "default";
      x-tiles = 15.0;
      y-tiles = 20.0;
    };

    "org/gnome/shell/extensions/user-theme" = {
      name = "WhiteSur-Dark";
    };

    "org/gnome/shell/extensions/wintile" = {
      rows = 1;
    };

    "org/gnome/software" = {
      check-timestamp = mkInt64 1698514389;
      first-run = false;
      flatpak-purge-timestamp = mkInt64 1698531172;
    };

    "org/gnome/tweaks" = {
      show-extensions-notice = false;
    };

    "org/gtk/gtk4/settings/file-chooser" = {
      date-format = "regular";
      location-mode = "path-bar";
      show-hidden = true;
      show-size-column = true;
      show-type-column = true;
      sidebar-width = 140;
      sort-column = "name";
      sort-directories-first = true;
      sort-order = "ascending";
      type-format = "category";
      view-type = "list";
      window-size = mkTuple [ 1173 668 ];
    };

    "org/gtk/settings/color-chooser" = {
      custom-colors = [ (mkTuple [ 0.17647058823529413 0.49019607843137253 0.7019607843137254 1.0 ]) ];
      selected-color = mkTuple [ true 0.17647058823529413 0.49019607843137253 0.7019607843137254 1.0 ];
    };

    "org/gtk/settings/file-chooser" = {
      clock-format = "12h";
      date-format = "regular";
      location-mode = "path-bar";
      show-hidden = false;
      show-size-column = true;
      show-type-column = true;
      sidebar-width = 197;
      sort-column = "type";
      sort-directories-first = false;
      sort-order = "ascending";
      type-format = "category";
      window-position = mkTuple [ 45 29 ];
      window-size = mkTuple [ 1188 546 ];
    };

    "org/mate/caja/window-state" = {
      geometry = "800x550+635+1567";
      maximized = false;
      sidebar-width = 148;
      start-with-sidebar = true;
      start-with-status-bar = true;
      start-with-toolbar = true;
    };

    "org/mate/desktop/accessibility/keyboard" = {
      bouncekeys-beep-reject = true;
      bouncekeys-delay = 300;
      bouncekeys-enable = false;
      enable = false;
      feature-state-change-beep = false;
      mousekeys-accel-time = 1200;
      mousekeys-enable = false;
      mousekeys-init-delay = 160;
      mousekeys-max-speed = 750;
      slowkeys-beep-accept = true;
      slowkeys-beep-press = true;
      slowkeys-beep-reject = false;
      slowkeys-delay = 300;
      slowkeys-enable = false;
      stickykeys-enable = false;
      stickykeys-latch-to-lock = true;
      stickykeys-modifier-beep = true;
      stickykeys-two-key-off = true;
      timeout = 120;
      timeout-enable = false;
      togglekeys-enable = false;
    };

    "org/mate/desktop/background" = {
      color-shading-type = "vertical-gradient";
      picture-filename = "/home/samuel/Pictures/wallpapertip_elliot-wallpaper_735422.jpg";
      picture-options = "stretched";
      primary-color = "rgb(88,145,188)";
      secondary-color = "rgb(60,143,37)";
      show-desktop-icons = true;
    };

    "org/mate/desktop/interface" = {
      window-scaling-factor = 1;
    };

    "org/mate/desktop/peripherals/mouse" = {
      accel-profile = "flat";
      motion-threshold = 8;
    };

    "org/mate/desktop/peripherals/touchpad" = {
      tap-to-click = true;
      three-finger-click = 0;
      two-finger-click = 0;
    };

    "org/mate/desktop/session" = {
      session-start = 1701465905;
    };

    "org/mate/engrampa/general" = {
      unar-open-zip = false;
    };

    "org/mate/engrampa/listing" = {
      list-mode = "as-folder";
      name-column-width = 250;
      show-path = false;
      sort-method = "name";
      sort-type = "ascending";
    };

    "org/mate/engrampa/ui" = {
      sidebar-width = 200;
      window-height = 480;
      window-width = 600;
    };

    "org/mate/marco/general" = {
      theme = "Menta";
    };

    "org/mate/panel/general" = {
      object-id-list = [ "menu-bar" "notification-area" "clock" "show-desktop" "window-list" "workspace-switcher" ];
      toplevel-id-list = [ "top" "bottom" ];
    };

    "org/mate/panel/objects/clock" = {
      applet-iid = "ClockAppletFactory::ClockApplet";
      locked = true;
      object-type = "applet";
      panel-right-stick = true;
      position = 0;
      toplevel-id = "top";
    };

    "org/mate/panel/objects/clock/prefs" = {
      custom-format = "";
      format = "24-hour";
    };

    "org/mate/panel/objects/menu-bar" = {
      locked = true;
      object-type = "menu-bar";
      position = 0;
      toplevel-id = "top";
    };

    "org/mate/panel/objects/notification-area" = {
      applet-iid = "NotificationAreaAppletFactory::NotificationArea";
      locked = true;
      object-type = "applet";
      panel-right-stick = true;
      position = 10;
      toplevel-id = "top";
    };

    "org/mate/panel/objects/show-desktop" = {
      applet-iid = "WnckletFactory::ShowDesktopApplet";
      locked = true;
      object-type = "applet";
      position = 0;
      toplevel-id = "bottom";
    };

    "org/mate/panel/objects/window-list" = {
      applet-iid = "WnckletFactory::WindowListApplet";
      locked = true;
      object-type = "applet";
      position = 20;
      toplevel-id = "bottom";
    };

    "org/mate/panel/objects/workspace-switcher" = {
      applet-iid = "WnckletFactory::WorkspaceSwitcherApplet";
      locked = true;
      object-type = "applet";
      panel-right-stick = true;
      position = 0;
      toplevel-id = "bottom";
    };

    "org/mate/panel/toplevels/bottom" = {
      expand = true;
      monitor = 1;
      orientation = "bottom";
      screen = 0;
      size = 24;
      y = 1055;
      y-bottom = 0;
    };

    "org/mate/panel/toplevels/top" = {
      expand = true;
      monitor = 1;
      orientation = "top";
      screen = 0;
      size = 24;
      y = 0;
      y-bottom = -1;
    };

    "org/virt-manager/virt-manager" = {
      manager-window-height = 550;
      manager-window-width = 550;
    };

    "org/virt-manager/virt-manager/vmlist-fields" = {
      disk-usage = false;
      network-traffic = false;
    };

  };


  

  


}