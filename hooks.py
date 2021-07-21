from os import system

def nvim():
    plug = """
    curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    """
    inst = "nvim --headless +PlugInstall +qa"

    system(plug)
    system(inst)

hooks = {
    '.config/nvim/': nvim,
}
