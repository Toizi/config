export PATH="/home/mg/.local/share/solana/install/active_release/bin:$PATH"

if command -v sway > /dev/null && [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  # fixes invisible cursor
  export WLR_NO_HARDWARE_CURSORS=1

  # recommended settings by flameshot
  # https://github.com/flameshot-org/flameshot/blob/master/docs/Sway%20and%20wlroots%20support.md
  export SDL_VIDEODRIVER=wayland
  export _JAVA_AWT_WM_NONREPARENTING=1
  export QT_QPA_PLATFORM=wayland
  export XDG_CURRENT_DESKTOP=sway
  export XDG_SESSION_DESKTOP=sway

  # allow keepass to populate ssh keys via agent
  exec ssh-agent sway --unsupported-gpu
fi
if command -v startx > /dev/null && [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi
