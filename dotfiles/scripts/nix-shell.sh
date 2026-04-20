#! /usr/bin/env bash

NIXPKGS_UNSTABLE_URL="github:NixOS/nixpkgs/nixos-unstable"

if [ $# -lt 1 ]; then
    echo "Usage: $0 <packages>"
    exit 1
fi

# Parse each package into a flake reference.
package_refs=()
for package in "$@"; do
    # Use unstable nixpkgs if requested via unstable/<package>.
    if [[ "$package" == unstable/* ]]; then
        package="${package#unstable/}"
        package_refs+=("$NIXPKGS_UNSTABLE_URL#$package")
    else
        package_refs+=("nixpkgs#$package")
    fi
done

exec nix shell "${package_refs[@]}"
