export PATH="/home/mg/.local/share/solana/install/active_release/bin:$PATH"

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi
