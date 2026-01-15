#! /usr/bin/env bash

if [ $# -lt 1 ]; then
    echo "Usage: $0 <package> [-- <args>]"
    exit 1
fi

package="$1"
shift

if [ "$1" = "--" ]; then
    shift
    # Pass in optional arguments
    exec nix run "nixpkgs#$package" -- "$@"
else
    exec nix run "nixpkgs#$package"
fi

