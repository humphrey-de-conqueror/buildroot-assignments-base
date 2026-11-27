#!/bin/bash
set -euo pipefail

cd "$(dirname "$0")"

QEMU_BIN="buildroot/output/host/bin/qemu-system-aarch64"
KERNEL="buildroot/output/images/Image"
ROOTFS="buildroot/output/images/rootfs.ext4"

for file in "$QEMU_BIN" "$KERNEL" "$ROOTFS"; do
    if [[ ! -e "$file" ]]; then
        echo "ERROR: Required file not found: $file" >&2
        exit 1
    fi
done

exec "$QEMU_BIN" \
    -M virt \
    -cpu cortex-a53 \
    -nographic \
    -smp 1 \
    -kernel "$KERNEL" \
    -append "rootwait root=/dev/vda console=ttyAMA0" \
    -netdev user,id=eth0,hostfwd=tcp::10022-:22,hostfwd=tcp::9000-:9000 \
    -device virtio-net-device,netdev=eth0 \
    -drive file="$ROOTFS",if=none,format=raw,id=hd0 \
    -device virtio-blk-device,drive=hd0 \
    -device virtio-rng-pci
