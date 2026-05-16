# ❄️ NixOS Config - COSMIC & Hyprland | Intel 13th Gen

Este repositório contém os arquivos de configuração do meu **NixOS (24.11)**, otimizado para um notebook Acer com processador **Intel Core i5 de 13ª Geração**.

O sistema foca no uso da interface **COSMIC (Epoch)** e do Window Manager **Hyprland**, priorizando extrema performance em Wayland e compatibilidade inteligente com partições Dual Boot.

---

## 🚀 Destaques do Sistema

* **Interfaces Gráficas:** COSMIC Desktop Environment e Hyprland (com suporte a XWayland).
* **Kernel:** `linuxPackages_latest` (Kernel Linux mais recente, garantindo máxima compatibilidade com hardware moderno).
* **Bootloader:** GRUB configurado especificamente para evitar que a partição EFI (100MB) lote rapidamente no Dual Boot (`configurationLimit = 3`, `copyKernels = false`).
* **Áudio:** Pipewire ativado para áudio de alta performance e baixa latência, incluindo suporte nativo a ALSA, PulseAudio e JACK.
* **Performance e Hardware:** * `zramSwap` habilitado para compressão de memória na RAM, deixando o uso muito mais fluido.
  * `thermald` controlando as temperaturas e bateria do processador Intel.
  * Otimizações de GPU Intel ativas (`i915.enable_guc=2` e aceleração de hardware).

---

## 📂 Estrutura dos Arquivos

| Arquivo | Descrição |
| :--- | :--- |
| **`configuration.nix`** | O núcleo do sistema. Define os módulos de boot, hardware base, teclado, áudio Pipewire, serviços do COSMIC, rede e usuários. |
| **`hardware-configuration.nix`** | Arquivo gerado automaticamente pelo sistema, mapeando discos, sistemas de arquivos (`ext4` e `vfat`) e firmwares necessários. |
| **`hyprland.nix`** | Ambiente Hyprland. Contém configuração do XDG Portal (para corrigir telas brancas), pacotes visuais (Waybar, Rofi) e variáveis fortes do Wayland. |
| **`programas.nix`** | Meu inventário modular de pacotes organizado por seções: Essenciais, Social, Desenvolvimento, Sistema, COSMIC e Estética. |
| **`visual.nix`** | Customização do shell bash (incluindo atalhos poderosos), inicialização do Starship e injeção do tema escuro no GTK. |

---

## 📦 Softwares Instalados (`programas.nix` e `hyprland.nix`)

Todos os aplicativos foram categorizados para tornar o arquivo legível e de fácil manutenção:

* **Terminal e Essenciais:** `git`, `vim`, `wget`, `curl`, `unzip`, `ncdu`, `kitty` e `starship` para o prompt.
* **Social e Navegação:** Navegador principal `brave` acompanhado de `librewolf`, `firefox` e `tor-browser`. Para comunicação e uso diário: `discord`, `spotify`, `obsidian` e `zapzap`.
* **Desenvolvimento:** Ambiente pronto para código com `vscode`, ecossistema Javascript/TypeScript (`nodejs_22`, `vercel`, `@angular/cli`), `wineWowPackages.stable` e `pywal`.
* **WM e Hyprland:** Componentes gráficos como `waybar`, `rofi`, `swww`, `dunst`, além do gerenciador de bluetooth `blueman` e controle visual do painel (`papirus-icon-theme`).
* **Controle de Sistema e Hardware:** Ferramentas gráficas e de terminal como `gparted`, `pavucontrol`, `networkmanagerapplet`, `pamixer`, `brightnessctl`, `hyprpaper` e monitores da Intel (`intel-gpu-tools`, `libva-utils`).
* **Gerenciadores de Arquivo e COSMIC:** App nativos como `cosmic-term` e `cosmic-files` trabalhando em conjunto com o poderoso `xfce.thunar` (com suporte a archives e thumbnails).
* **Estética:** Aplicativos de status e diversão no terminal, incluindo `cava`, `neofetch`, `btop`, `cmatrix`, `neo`, `peaclock` e `sl`.

---

## ⌨️ Atalhos e Aliases (`visual.nix`)

O sistema conta com aliases práticos criados no Bash para otimizar operações repetitivas:

| Alias | Comando Executado | Função |
| :--- | :--- | :--- |
| `reconfig` | `sudo nixos-rebuild switch -I nixos-config=/home/tempz/.../configuration.nix` | Aplica as mudanças no NixOS apontando diretamente para o caminho deste repositório clonado. |
| `limpar` | `sudo nix-collect-garbage -d` | Remove o lixo do Nix, deletando gerações antigas e poupando espaço no disco. |
| `ll` | `ls -l` | Exibe listagem rápida e detalhada de diretórios. |
| `matrix` | `neo -D` | Roda o efeito moderno inspirado em Matrix. |
| `ren` | `reboot` | Reinicia o notebook de forma imediata. |
| `des` | `poweroff` | Desliga o notebook de forma imediata. |

---

## 🔧 Configurações Específicas e Wayland

### 1. Bootloader e Limpeza Inteligente
* **EFI & GRUB:** Para evitar problemas clássicos com placas Acer, a instalação EFI ocorre como removível (`efiInstallAsRemovable = true`).
* **Nix Store:** O sistema faz a autootimização no SSD deduplicando o repositório (`auto-optimise-store = true`) e o *Garbage Collector* roda de forma automática semanalmente excluindo configurações com mais de 7 dias (`--delete-older-than 7d`). Serviço de TRIM do SSD ativado (`services.fstrim.enable = true`).

### 2. Aceleração e Variáveis de Ambiente Wayland
A experiência fluida nos aplicativos no Hyprland e no COSMIC dependem do arquivo `hyprland.nix`:
* **Portais:** `xdg-desktop-portal-gtk` ativado, o que soluciona bugs de "telas brancas" para buscar arquivos pelo Discord ou VS Code.
* **Electron Nativo:** `NIXOS_OZONE_WL = "1"` força que os aplicativos Electron rodem no protocolo nativo do Wayland, corrigindo borrões na resolução.
* **Otimização de Render:** `MOZ_ENABLE_WAYLAND = "1"` força o WebRender via hardware nos navegadores, e cursores acelerados desabilitados via `WLR_NO_HARDWARE_CURSORS = "1"`.
* **Intel Drivers:** Vínculos para `VDPAU_DRIVER = "va_gl"` e `LIBVA_DRIVER_NAME = "iHD"`.

### 3. Fontes Otimizadas
As fontes instaladas garantem que todos os componentes da *Waybar* e do prompt *Starship* fiquem com a renderização correta sem falhas de layout: Nerd Fonts (`fira-code` e `jetbrains-mono`).