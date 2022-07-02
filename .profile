. "$HOME/.cargo/env"

export PATH="/home/mg/.local/share/solana/install/active_release/bin:$PATH"

# mount backup drive
# udisksctl mount -b /dev/disk/by-uuid/3c47edbb-cdd1-4dce-bde5-8062e407faa8 1>/dev/null 2>&1

# power off spinning backup drive safely (don't since backups don't work then)
# udisksctl power-off -b /dev/disk/by-uuid/3AB4833FB482FC9F >/dev/null 2>&1

# set standby to X*5 seconds so the disk stops spinning whenever it is not needed
# sudo hdparm -S10 /dev/disk/by-uuid/3AB4833FB482FC9F 1>/dev/null 2>&1
