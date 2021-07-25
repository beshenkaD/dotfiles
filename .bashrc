source ~/.profile

# Use bash completion if avaliable
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] &&
	. /usr/share/bash-completion/bash_completion

# History
export HISTCONTROL=ignoreboth:erasedups
shopt -s histappend

# Enable colors
alias ls='ls --color=auto'
alias grep='grep --color=auto' # Aliases
alias cp='cp -i'     # Confirm before overwriting
alias df='df -h'     # Human-readable sizes
alias free='free -m' # Sizes in MB
alias sudo='sudo '   # make sudo resolve aliases
alias ..='cd ..'
alias ...='cd ../..'

. /etc/os-release
if [ "$NAME" != "Gentoo Linux" ]; then
    # In Gentoo i can use eselect-vi
    alias vi=nvim
fi

if [ "$NAME" = "Arch Linux" ]; then
	alias pacman_depclean='pacman -R $(pacman -Qtdq)'
fi

# Git promt

COLOR_GIT_CLEAN='\[\033[1;30m\]'
COLOR_GIT_MODIFIED='\[\033[0;33m\]'
COLOR_GIT_STAGED='\[\033[0;36m\]'
COLOR_RESET='\[\033[0m\]'

git_prompt() {
  export LC_ALL=C
  if [ -e ".git" ]; then
    branch_name=$(git symbolic-ref -q HEAD)
    branch_name=${branch_name##refs/heads/}
    branch_name=${branch_name:-HEAD}

    echo -n "> "

    if [[ $(git status 2> /dev/null | tail -n1) = *"nothing to commit"* ]]; then
      echo -n "$COLOR_GIT_CLEAN$branch_name$COLOR_RESET"
    elif [[ $(git status 2> /dev/null | head -n5) = *"Changes to be committed"* ]]; then
      echo -n "$COLOR_GIT_STAGED$branch_name$COLOR_RESET"
    else
      echo -n "$COLOR_GIT_MODIFIED$branch_name*$COLOR_RESET"
    fi

    echo -n " "
  fi
}

prompt() {
	GRN="\[$(tput setaf 2)\]"
	BLU="\[$(tput setaf 4)\]"
	RES="\[$(tput sgr0)\]"

	PS1="$GRN\u$RES@$BLU\H$RES [ \w $(git_prompt)] \$ "
}

PROMPT_COMMAND=prompt

# Paste to ix.io
ix() {
	local opts
	local OPTIND
	[ -f "$HOME/.netrc" ] && opts='-n'
	while getopts ":hd:i:n:" x; do
		case $x in
		h)
			echo "ix [-d ID] [-i ID] [-n N] [opts]"
			return
			;;
		d)
			$echo curl $opts -X DELETE ix.io/$OPTARG
			return
			;;
		i)
			opts="$opts -X PUT"
			local id="$OPTARG"
			;;
		n) opts="$opts -F read:1=$OPTARG" ;;
		esac
	done
	shift $(($OPTIND - 1))
	[ -t 0 ] && {
		local filename="$1"
		shift
		[ "$filename" ] && {
			curl $opts -F f:1=@"$filename" $* ix.io/$id
			return
		}
		echo "^C to cancel, ^D to send."
	}
	curl $opts -F f:1='<-' $* ix.io/$id
}
