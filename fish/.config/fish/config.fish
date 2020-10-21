set PATH /home/drakkari/.local/bin $PATH
set PATH /home/drakkari/.local/bin/statusbar $PATH
set PATH /home/drakkari/go/ $PATH
set GOPATH /home/drakkari/go

export VISUAL="nvim"
export EDITOR="nvim"
export TERMINAL="st"

# pfetch config
export PF_INFO="ascii title os kernel pkgs memory wm shell term editor palette"

# Autostart x at login
if [ -z $DISPLAY ] && [ (tty) = /dev/tty1 ]
    exec startx "$HOME/.xinitrc"
end
