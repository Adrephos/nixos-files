{ pkgs, ... }:

let
  netns = "proton";
  wgInterface = "${netns}0";

  protonPortForward = pkgs.writeShellScript "proton-port-forward" ''
    set -uo pipefail

    PATH=${
      pkgs.lib.makeBinPath [
        pkgs.coreutils
        pkgs.curl
        pkgs.gnused
        pkgs.iptables
        pkgs.libnatpmp
      ]
    }

    GATEWAY="10.2.0.1"
    QB_URL="http://127.0.0.1:8080"
    CHAIN="proton-pmp"

    COOKIE_JAR="$(mktemp)"
    trap 'rm -f "$COOKIE_JAR"' EXIT

    # Inbound is DROP by default inside the namespace; open only the forwarded port.
    open_port() {
      iptables -N "$CHAIN" 2>/dev/null || true
      iptables -C INPUT -i ${wgInterface} -j "$CHAIN" 2>/dev/null \
        || iptables -I INPUT 1 -i ${wgInterface} -j "$CHAIN"
      iptables -F "$CHAIN"
      iptables -A "$CHAIN" -p tcp --dport "$1" -j ACCEPT
      iptables -A "$CHAIN" -p udp --dport "$1" -j ACCEPT
    }

    login_qbittorrent() {
      curl --silent --show-error --fail \
        --cookie-jar "$COOKIE_JAR" \
        --data-urlencode "username=''${QB_USERNAME:-}" \
        --data-urlencode "password=''${QB_PASSWORD:-}" \
        "$QB_URL/api/v2/auth/login" >/dev/null
    }

    set_qbittorrent_port() {
      echo "Setting qBittorrent listening port to $1"
      login_qbittorrent || { echo "qBittorrent login failed"; return 1; }
      curl --silent --show-error --fail \
        --cookie "$COOKIE_JAR" \
        --data-urlencode "json={\"listen_port\":$1,\"upnp\":false,\"random_port\":false}" \
        "$QB_URL/api/v2/app/setPreferences" >/dev/null
    }

    echo "Waiting for Proton NAT-PMP gateway..."
    until natpmpc -g "$GATEWAY" >/dev/null 2>&1; do
      sleep 5
    done
    echo "Proton NAT-PMP gateway reachable"

    CURRENT_PORT=""

    while true; do
      UDP_OUTPUT="$(natpmpc -a 1 0 udp 60 -g "$GATEWAY" 2>&1)" || {
        echo "UDP NAT-PMP request failed: $UDP_OUTPUT"
        sleep 5
        continue
      }

      PORT="$(printf '%s\n' "$UDP_OUTPUT" | sed -n 's/.*Mapped public port \([0-9][0-9]*\).*/\1/p')"
      if [ -z "$PORT" ]; then
        echo "Could not parse forwarded port: $UDP_OUTPUT"
        sleep 5
        continue
      fi

      # Ask for the same public port over TCP as UDP so both match.
      TCP_OUTPUT="$(natpmpc -a "$PORT" "$PORT" tcp 60 -g "$GATEWAY" 2>&1)" || {
        echo "TCP NAT-PMP request failed: $TCP_OUTPUT"
        sleep 5
        continue
      }

      if [ "$PORT" != "$CURRENT_PORT" ]; then
        open_port "$PORT"
        if set_qbittorrent_port "$PORT"; then
          CURRENT_PORT="$PORT"
          echo "Forwarded port is now $PORT"
        else
          echo "Failed to update qBittorrent; will retry next cycle"
        fi
      fi

      sleep 45
    done
  '';
in
{
  systemd.services.proton-port-forward = {
    description = "Proton VPN NAT-PMP port forwarding for qBittorrent";

    after = [ "qbittorrent.service" ];
    requires = [ "qbittorrent.service" ];
    wantedBy = [ "multi-user.target" ];

    vpnConfinement = {
      enable = true;
      vpnNamespace = netns;
    };

    serviceConfig = {
      Type = "simple";
      # Optional: QB_USERNAME / QB_PASSWORD, only needed if the WebUI requires auth on localhost.
      EnvironmentFile = "-/etc/qbittorrent-proton.env";
      ExecStart = protonPortForward;
      Restart = "always";
      RestartSec = 5;
    };
  };
}
