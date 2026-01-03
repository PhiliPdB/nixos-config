#! /usr/bin/env bash
# First argument for the template name

if (( $# != 1 )); then
    echo "Invalid number of arguments"
    exit 1
fi

# Check if flake.nix exists and ask user if he wants to overwrite
if [ -f ./flake.nix ]; then
    # Ask to overwrite flake.nix
    read -rp "flake.nix already exists. Want to overwrite? [yn] " yn
    case $yn in
        [Yy]*) ;;
        [Nn]*) exit 1;;
        * ) echo "Please answer Y or N"; exit 1;;
    esac
fi

# TODO: Load dir from config?
TEMPLATE_DIR=~/repositories/flake-templates
TEMPLATE="$1"

TEMPLATE_PATH="$TEMPLATE_DIR/$TEMPLATE.nix"
if [ -f "$TEMPLATE_PATH" ]; then
    cp "$TEMPLATE_PATH" ./flake.nix
else
    echo "Template '$TEMPLATE' does not exist"
fi

