{ pkgs, inputs, ... }:
let
  zen-browser = inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default;
  pythonEnv = pkgs.python313.withPackages (
    ps: with ps; [
      torch-bin
      torchvision-bin
      (manga-ocr.overridePythonAttrs (old: {
        dependencies = (builtins.filter (d: d.pname or "" != "torch") old.dependencies) ++ [ torch-bin ];
      }))
    ]
  );
in
{
  environment.systemPackages = with pkgs; [
    zen-browser

    # Java Zzzz
    jdk
    jdk11
    jdk21
    maven
    gradle

    #zig
    zig

    # Go
    go
    wgo
    air
    templ
    cobra-cli

    #Tecladito
    keymapp

    # Droidcam
    v4l-utils
    droidcam

    # Development
    glab
    neovim
    imagemagick
    gcc
    cmake
    scrcpy
    simple-mtpfs
    gnumake
    linuxHeaders

    # Tools
    appimage-run
    whisper-cpp
    caligula # iso image
    rclone
    cargo
    nil
    rar
    unzip
    bruno
    postman
    openvpn
    ripgrep
    obsidian
    tree-sitter
    texlive.combined.scheme-full
    ghostscript
    python311Packages.pylatexenc
    nixfmt
    networkmanager-vpnc
    wg-netmanager

    # Utils
    android-tools
    file
    onlyoffice-desktopeditors
    gpu-screen-recorder
    nautilus
    glib
    gsettings-desktop-schemas

    # owasp
    # zap
    # burpsuite

    # Learning
    codecrafters-cli
    exercism
    pythonEnv
    anki

    foliate

    # Erlang
    # erlang
    gleam
    elixir

    # de juguete
    pnpm
    nodejs
    uv
    python3
    python312Packages.pip
    python312Packages.jupytext
    vscodium

    # La vida
    discord
    vesktop
    protonplus
    sgdboop

    zoom-us
    pulseaudio
    pavucontrol
    prismlauncher
    proton-vpn
    proton-pass
    redland-wayland
    claude-code

    ffmpeg-full
    libva-utils
  ];
}
