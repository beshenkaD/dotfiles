# Dotfiles
My dotfiles.

# Elements used
## Visual
* Colorscheme - base16-harmonic-light
* Gtk theme - Adwaita
* Icon theme - Papirus

## Environment
* Polybar - nuff said
* Dunst   - notification daemon
* Bspwm + sxhkd   - window manager
* Alacritty - terminal emulator
* i3lock - screen locker
* Bash - nuff said
* Emacs - operating system
* Neovim - text editor
* Rofi - dmenu replacement
* Xsettingsd - gtk settings daemon
* Picom - compositor

# TODO
- [ ] Organize dotfiles and scripts better
- [ ] Add powermenu to rofi
- [ ] Fix rofi colors
- [ ] Make day/night colorscheme switch
- [ ] Create unified config for vim and neovim
- [ ] Replace alacritty with something else
- [ ] Replace i3lock with light-locker, and 'startx' with lightdm
- [ ] Add encryption support to dot.py
- [ ] Add screenshots
- [ ] Take wallpapers from internet

# Installation
```shell
./dot.py --hooks --install .config/{emacs,nvim,whatever}
```
