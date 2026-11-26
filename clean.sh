#!/bin/bash
set -euo pipefail

cd "$(dirname "$0")"

BUILDROOT_DIR="buildroot"

if [[ ! -d "$BUILDROOT_DIR/output" ]]; then
    echo "Buildroot output directory does not exist."
else
    echo "Removing generated Buildroot output..."
    rm -rf -- "$BUILDROOT_DIR/output"
fi

if [[ -f "$BUILDROOT_DIR/.config" ]]; then
    echo "Removing generated Buildroot configuration..."
    rm -f -- "$BUILDROOT_DIR/.config"
fi

echo "Removing generated assignment test artifacts..."
rm -f -- assignment4-result.txt rootfs.ext2

echo "Clean completed."
echo "Preserved: Buildroot sources, submodules, external tree, and download cache."
