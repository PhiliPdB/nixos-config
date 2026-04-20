#! /usr/bin/env bash

NIXPKGS_UNSTABLE_URL="github:NixOS/nixpkgs/nixos-unstable"

if [ $# -lt 1 ]; then
    echo "Usage: $0 [unstable/]<package> [-- <args>]"
    exit 1
fi

# Extract package name
package="$1"

# Check if packages should be fetched from unstable or stable
if [[ "$package" == unstable/* ]]; then
    package="${package#unstable/}"
    package_ref="$NIXPKGS_UNSTABLE_URL#$package"
else
    package_ref="nixpkgs#$package"
fi

shift

if [ "$1" = "--" ]; then
    shift
    # Pass in optional arguments
    exec nix run "$package_ref" -- "$@"
else
    exec nix run "$package_ref"
fi

