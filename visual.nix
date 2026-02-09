{ pkgs, ... }: {
  programs.bash.shellAliases = {
    reconfigurar = "sudo nixos-rebuild switch -I nixos-config=/home/tempz/Documentos/minha-config-nixOS/configuration.nix";
    ll = "ls -l";
    limpar = "sudo nix-collect-garbage -d";
    matrix = "neo -D";
    reniciar = "sudo reboot";
    desligar = "sudo poweroff";
  };

  programs.starship.enable = true;
  
  # Variáveis de ambiente para o Pywal ou Temas
  environment.sessionVariables = {
    EDITOR = "vim";
  };
}
