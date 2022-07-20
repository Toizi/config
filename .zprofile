export PATH="/home/mg/.local/share/solana/install/active_release/bin:$PATH"

if command -v startx > /dev/null && [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi
