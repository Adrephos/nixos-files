set shell := ["bash", "-euo", "pipefail", "-c"]

default:
    @just --list

# Format the Vin-owned Nix files with the flake formatter.
fmt:
    nix fmt -- flake.nix hosts/vin modules/nixos home/gleipnir

# Evaluate flake outputs without updating inputs or building closures.
check:
    nix flake check --no-build --no-write-lock-file

# Build Vin without creating a result symlink.
build:
    nix build --no-link --print-out-paths .#nixosConfigurations.vin.config.system.build.toplevel

# Activate Vin temporarily; a reboot returns to the previous generation.
test:
    nh os test . -H vin

# Build and make Vin the active boot generation.
switch:
    nh os switch . -H vin

# Refresh flake inputs (all, or just the given one). Review flake.lock, then run check and build.
update input="":
    nix flake update {{ input }}
