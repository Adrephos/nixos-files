{
  imports = [
    ../shared
    ./packages.nix
    ./users.nix
    ../services/docker.nix
    ../services/openssh.nix
    ../services/jellyfin.nix
    ../services/qbittorrent.nix
    ../services/proton-port-forwarding.nix
    ../services/actual-budget.nix
    ../services/calibre-web.nix
    ../services/samba.nix
    ../services/tmux.nix
    ../services/glances.nix
    ../services/pihole.nix
    ../services/tailscale.nix
  ];

  hardware.enableRedistributableFirmware = true;
}
