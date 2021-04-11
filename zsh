alias -g ls="ls --color=auto"
alias -g cp="cp -iv"
alias -g mv="mv -iv"
alias -g ix="curl -F 'f:1=<-' ix.io"
alias -g password="< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-12};echo;"
alias -g neofetch='neofetch --size 250px --sixel Pictures/neofetch.png'

test -r ~/.dir_colors && eval $(dircolors ~/.dir_colors)

export PATH=/home/$USER/.local/bin:$PATH
export PATH=/home/$USER/go/bin:$PATH
export PATH=/home/$USER/Documents/Appimages:$PATH

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/beshenka/.zshrc'

autoload -U compinit promptinit
compinit
promptinit; prompt gentoo

# zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
# zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'

setopt correctall
setopt histignoredups
setopt autocd

# PROMT_ICON='  '
# PROMT_ICON='ᛋᛋ'
PROMT_ICON='ᛟ'
PROMPT="%(?.%F{blue} $(tput bold)${PROMT_ICON}.%F{red}?%?)%f %B%F{240}%1~%f%b %# "

# Git integration
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats '%F{240}(%b)%r%f'
zstyle ':vcs_info:*' enable git

. /usr/share/zsh/site-functions/zsh-syntax-highlighting.zsh
