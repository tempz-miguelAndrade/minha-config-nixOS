{ pkgs, ... }: {
  programs.bash.shellAliases = {
    reconfig = "nixos-rebuild switch -I nixos-config=/home/tempz/Documentos/minha-config-nixOS/configuration.nix";
    ll = "ls -l";
    limpar = "sudo nix-collect-garbage -d";
    matrix = "neo -D";
    ren = "reboot";
    des = "poweroff";
  };

  programs.starship.enable = true;
  
  # Forçar Modo Escuro e Tamanhos compactos
  environment.sessionVariables = {
    EDITOR = "vim";
    GTK_THEME = "Adwaita:dark";
    GDK_DPI_SCALE = "0.9"; 
    _JAVA_OPTIONS = "-Dsun.java2d.uiScale=0.9";
  };

  # =========================================================================
  # 🚀 CENTRALIZAÇÃO AUTOMÁTICA DOS DOTFILES (Para subir no GitHub com tudo)
  # =========================================================================
  environment.etc = {
    # 1. Vincula o hyprland.conf
    "xdg/hypr/hyprland.conf".source = ./dotfiles/hypr/hyprland.conf;
    
    # 2. Vincula a Waybar (config e style.css)
    "xdg/waybar/config".source = ./dotfiles/waybar/config;
    "xdg/waybar/style.css".source = ./dotfiles/waybar/style.css;
    
    # 3. Vincula o Starship Prompt
    "xdg/starship.toml".source = ./dotfiles/starship.toml;
    
    # 4. Vincula as definições escuras do GTK
    "xdg/gtk-3.0/settings.ini".source = ./dotfiles/gtk-3.0/settings.ini;
  };
}