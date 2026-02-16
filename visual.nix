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
  
  # Variáveis de ambiente para o Pywal ou Temas
  environment.sessionVariables = {
    EDITOR = "vim";
  };
}
