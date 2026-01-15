{ config, pkgs, ... }: { 
    
    imports = [ ./hardware-configuration.nix ./programas.nix ./visual.nix ];

    # bootloader
    boot.loader.systemd-boot.enable = false; 
    boot.loader.efi.canTouchEfiVariables = true;

    # grubloader
    boot.loader.grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
    };
    
    # kernel - Ótima escolha para hardware novo (Raptor Lake)
    boot.kernelPackages = pkgs.linuxPackages_latest;

    # rede e hardware
    networking.hostName = "nixos-tempz";
    networking.networkmanager.enable = true;
    nixpkgs.config.allowUnfree = true;

    # otimizações da interface cosmic
    nix.settings.download-buffer-size = 250000000;
    nix.settings.max-jobs = 1;
    hardware.enableAllFirmware = true; # Isso é crucial para o seu som Intel SOF

    # teclado
    console.keyMap = "br-abnt2";
    i18n.defaultLocale = "pt_BR.UTF-8";

    # teclado pra interface
    services.xserver.xkb = {
        layout = "br";
        variant = "";
    };
    
    # usuário 
    users.users.tempz = {
        isNormalUser = true;
        extraGroups = [ "wheel" "networkmanager" "video" "audio" ]; # Adicionei "audio" por garantia
    };

    # --- CORREÇÃO DO ÁUDIO AQUI ---
    
    # O PipeWire precisa do RTKit para ganhar prioridade no processador e não picotar o som
    security.rtkit.enable = true;
    
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        
        # Se você usar Jack (música profissional), descomente abaixo, mas para uso normal não precisa
        # jack.enable = true; 
    };
    
    # Garantia extra para firmwares de áudio modernos
    hardware.firmware = with pkgs; [
        sof-firmware
    ];

    boot.kernelParams = [
        "snd-intel-dspcfg.dsp_driver=3"
    ];

    # ------------------------------

    hardware.graphics.enable = true;

    # ferramentas e programas
    programs.starship.enable = true;

    # interface cosmic
    services.desktopManager.cosmic.enable = true;
    services.displayManager.cosmic-greeter.enable = true;

    # versão
    system.stateVersion = "24.11";
}
