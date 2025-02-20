#!/usr/bin/env bash

# Update the flake
echo "Updating flake..."
nix flake update

if [ ! -z "$1" ]; then
    echo "Applying to $1"
    # Apply to system in first argument
    sudo nixos-rebuild switch --flake ".#$1" --show-trace
fi
