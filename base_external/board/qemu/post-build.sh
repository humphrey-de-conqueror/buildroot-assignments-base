
#!/bin/sh
set -eu

TARGET_DIR="$1"
SSHD_CONFIG="${TARGET_DIR}/etc/ssh/sshd_config"
DROPBEAR_INIT="${TARGET_DIR}/etc/init.d/S50dropbear"

if [ ! -f "$SSHD_CONFIG" ]; then
    echo "ERROR: OpenSSH configuration not found: $SSHD_CONFIG" >&2
    exit 1
fi

set_sshd_option() {
    option="$1"
    value="$2"

    if grep -qE "^[#[:space:]]*${option}[[:space:]]+" "$SSHD_CONFIG"; then
        sed -i -E \
            "s|^[#[:space:]]*${option}[[:space:]]+.*|${option} ${value}|" \
            "$SSHD_CONFIG"
    else
        printf '%s %s\n' "$option" "$value" >> "$SSHD_CONFIG"
    fi
}

# Permit root authentication for assignment SSH/SCP tests.
set_sshd_option PermitRootLogin yes
set_sshd_option PasswordAuthentication yes

# Keep Dropbear compiled, but let OpenSSH own port 22.
rm -f "$DROPBEAR_INIT"
