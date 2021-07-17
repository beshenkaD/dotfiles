hooks = {
    '.config/nvim/': """curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
                https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    nvim --headless +PlugInstall +qa""",

    '.config/emacs/': 'rm -rf ~/.emacs.d ~/.config/emacs.d ~/.emacs',
}
