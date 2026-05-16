{ pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # CONFIGURAÇÃO DOS PORTALS (Resolve telas brancas de arquivos no VS Code/Discord)
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = [ "gtk" ];
  };

  environment.systemPackages = with pkgs; [
    waybar
    rofi
    papirus-icon-theme
    swww
    dunst
    libnotify
    kitty
    networkmanagerapplet
    pamixer          # Controla o volume via terminal
    brightnessctl    # Controla o brilho da tela
    playerctl        # Controla o Spotify (play/pause)
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code      # FONTE PARA OS ÍCONES APARECEREM NA WAYBAR
  ];

  # ATIVAR O GERENCIADOR GRÁFICO DO BLUETOOTH
  services.blueman.enable = true;

  environment.sessionVariables = {
    # Força aplicativos Electron/Chromium (Brave, VS Code, Discord) a usarem Wayland nativo com aceleração
    NIXOS_OZONE_WL = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
    
    # Otimizações de desempenho para drivers Intel no Wayland
    VDPAU_DRIVER = "va_gl";
    LIBVA_DRIVER_NAME = "iHD";
    
    # Força renderização via Hardware WebRender no Firefox e similares
    MOZ_ENABLE_WAYLAND = "1";
  };
}