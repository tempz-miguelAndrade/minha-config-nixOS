{ pkgs, ... }: {
  programs.bash.shellAliases = {
    reconfig = "sudo nixos-rebuild switch -I nixos-config=/home/tempz/Documentos/minha-config-nixOS/configuration.nix";
    ll = "ls -l";
    limpar = "sudo nix-collect-garbage -d";
    matrix = "neo -D";
    ren = "reboot";
    des = "poweroff";
  };

  programs.starship.enable = true;
  
  # Forçar Modo Escuro nos painéis gráficos (E o tamanho compacto das janelas que arrumamos antes)
  environment.sessionVariables = {
    EDITOR = "vim";
    GTK_THEME = "Adwaita:dark";
    
    GDK_DPI_SCALE = "0.9"; 
    _JAVA_OPTIONS = "-Dsun.java2d.uiScale=0.9";
  };
}