### Volume control
```xdotool key XF86AudioRaiseVolume```
```xdotool key XF86AudioLowerVolume```
```xdotool key XF86AudioMute```

### Song control
- Play/pause
  ```dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause```
- Previous/next
  ```dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next```
  ```dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous```
