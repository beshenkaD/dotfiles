source ~/.profile

# Use trash-cli
alias rm='echo "This is not the command you are looking for."; false'
# paste
alias ix="curl -F 'f:1=<-' ix.io"

# Verbosity and settings that you pretty much just always are going to want.
alias cp="cp -iv" 
alias mv="mv -iv" 
alias mkd="mkdir -pv"

set -gx GOPATH $HOME/go
set -gx PATH /home/beshenka/.local/bin $PATH
set -gx PATH /home/beshenka/go/bin $PATH

set EDITOR   nvim
set TERMINAL alacritty
set FILE     nnn
set PAGER    less

set MOZ_ENABLE_WAYLAND 1
set QT_QPA_PLATFORM    wayland
set GDK_BACKEND        wayland
set XDG_SESSION_TYPE   wayland
