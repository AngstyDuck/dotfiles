### Volume control
- Increase volume
  ```amixer -D pulse sset Master 5%+```
- Decrease volume
  ```amixer -D pulse sset Master 5%-```
- Toggle mute
  ```amixer -D pulse set Master 1+ toggle```

### Song control
- Play/pause
  ```dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause```
- Previous/next
  ```dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next```
  ```dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous```
