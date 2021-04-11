alias ix="curl -F 'f:1=<-' ix.io"

alias cp="cp -iv" 
alias mv="mv -iv" 
alias mkd="mkdir -pv"

set -gx GOPATH $HOME/go
set -gx PATH /home/beshenka/.local/bin $PATH
set -gx PATH /home/beshenka/go/bin $PATH
set -gx PATH /home/beshenka/Documents/Appimages $PATH

set EDITOR   nvim
set TERMINAL xterm

set fish_greeting ""
