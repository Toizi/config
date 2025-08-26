export PATH="/home/mg/.local/share/solana/install/active_release/bin:$PATH"
export PATH="/home/mg/.foundry/bin:$PATH"

if command -v sway > /dev/null && [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  # fixes invisible cursor
  # export WLR_NO_HARDWARE_CURSORS=1

  # unsure if this is strictly better than the default
  # export WLR_RENDERER=vulkan

  # recommended settings by flameshot
  # https://github.com/flameshot-org/flameshot/blob/master/docs/Sway%20and%20wlroots%20support.md
  export SDL_VIDEODRIVER=wayland
  export _JAVA_AWT_WM_NONREPARENTING=1
  export QT_QPA_PLATFORM=wayland
  export XDG_CURRENT_DESKTOP=sway
  export XDG_SESSION_DESKTOP=sway

  # a fix for xwayland apps turning black
  # export XWAYLAND_NO_GLAMOR=1

  # app specific settings
  export MOZ_ENABLE_WAYLAND=1

  # allow keepass to populate ssh keys via agent
  exec ssh-agent systemd-cat --identifier=sway sway
fi

# fallback to x
if command -v startx > /dev/null && [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi
