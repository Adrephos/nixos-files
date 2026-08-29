set shell := ["bash", "-euo", "pipefail", "-c"]

default:
    @just --list

# Format the repository's Nix files with the flake formatter.
fmt:
    nix fmt -- flake.nix hosts modules home/gleipnir

# Evaluate flake outputs without updating inputs or building closures.
check:
    nix flake check --no-build --no-write-lock-file

# Build a host without creating a result symlink.
build host="vin":
    nix build --no-link --print-out-paths .#nixosConfigurations.{{host}}.config.system.build.toplevel

# Activate a host temporarily; a reboot returns to the previous generation.
test host="vin":
    nh os test . -H {{host}}

# Build and make a host the active boot generation.
switch host="vin":
    nh os switch . -H {{host}}

# Refresh flake inputs (all, or just the given one). Review flake.lock, then run check and build.
update input="":
    nix flake update {{ input }}
