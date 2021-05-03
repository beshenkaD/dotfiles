#!/bin/sh

start() {
    killall -q $1
    while pgrep -x $1 >/dev/null; do sleep 1; done
    $@ &
}

alacritty_gruvbox_dark="# Colors
colors:
  primary:
    # hard contrast background - '#1d2021'
    background:        &gruvbox_dark_bg '#282828'
    # soft contrast background - '#32302f'
    foreground:        '#fbf1c7'
    bright_foreground: '#f9f5d7'
    dim_foreground:    '#f2e5bc'
  cursor:
    text:   CellBackground
    cursor: CellForeground
  vi_mode_cursor:
    text:   CellBackground
    cursor: CellForeground
  selection:
    text:       CellBackground
    background: CellForeground
  bright:
    black:   '#928374'
    red:     '#fb4934'
    green:   '#b8bb26'
    yellow:  '#fabd2f'
    blue:    '#83a598'
    magenta: '#d3869b'
    cyan:    '#8ec07c'
    white:   '#ebdbb2'
  normal:
    black:   *gruvbox_dark_bg
    red:     '#cc241d'
    green:   '#98971a'
    yellow:  '#d79921'
    blue:    '#458588'
    magenta: '#b16286'
    cyan:    '#689d6a'
    white:   '#a89984'
  dim:
    black:   '#32302f'
    red:     '#9d0006'
    green:   '#79740e'
    yellow:  '#b57614'
    blue:    '#076678'
    magenta: '#8f3f71'
    cyan:    '#427b58'
    white:   '#928374'
"

alacritty_papercolor_light="# Colors
colors:
  primary:
    background: '0xeeeeee'
    foreground: '0x4d4d4c'
  cursor:
    text: '0xf3f3f3'
    cursor: '0x4d4d4c'
  normal:
    black:   '0xededed'
    red:     '0xd7005f'
    green:   '0x718c00'
    yellow:  '0xd75f00'
    blue:    '0x4271ae'
    magenta: '0x8959a8'
    cyan:    '0x3e999f'
    white:   '0x4d4d4c'
  bright:
    black:   '0x949494'
    red:     '0xd7005f'
    green:   '0x718c00'
    yellow:  '0xd75f00'
    blue:    '0x4271ae'
    magenta: '0x8959a8'
    cyan:    '0x3e999f'
    white:   '0xf5f5f5'
"

set_dark() {
    # Alacritty
    sed -i '/# Colors/,$d' ~/.config/alacritty/alacritty.yml
    echo "$alacritty_gruvbox_dark" >> ~/.config/alacritty/alacritty.yml

    # Vim
    sed -i 's/set background=.*/set background=dark/' ~/.config/nvim/init.vim
    sed -i 's/colorscheme .*/colorscheme gruvbox/' ~/.config/nvim/init.vim
    sed -i 's/airline_theme=.*/airline_theme="gruvbox"/' ~/.config/nvim/init.vim

    # Cmus
    sed -i 's/colorscheme .*/colorscheme gruvbox/' ~/.config/cmus/rc

    # Gtk
    sed -i 's/Net\/ThemeName .*/Net\/ThemeName "Adwaita-dark"/' \
        ~/.config/xsettingsd/xsettingsd.conf

    sed -i 's/Net\/IconThemeName .*/Net\/IconThemeName "Papirus-Dark"/' \
        ~/.config/xsettingsd/xsettingsd.conf

    start xsettingsd

    # Polybar
    start polybar main --config=~/.config/polybar/config_dark

    notify-send -c normal "Dark theme has applied"
}

set_light() {
    # Alacritty
    sed -i '/# Colors/,$d' ~/.config/alacritty/alacritty.yml
    echo "$alacritty_papercolor_light" >> ~/.config/alacritty/alacritty.yml

    # Vim
    sed -i 's/set background=.*/set background=light/' ~/.config/nvim/init.vim
    sed -i 's/colorscheme .*/colorscheme PaperColor/' ~/.config/nvim/init.vim
    sed -i 's/airline_theme=.*/airline_theme="papercolor"/' ~/.config/nvim/init.vim

    # Cmus
    sed -i 's/colorscheme .*/colorscheme papercolor-light/' ~/.config/cmus/rc

    # Gtk
    sed -i 's/Net\/ThemeName .*/Net\/ThemeName "Adwaita"/' \
        ~/.config/xsettingsd/xsettingsd.conf

    sed -i 's/Net\/IconThemeName .*/Net\/IconThemeName "Papirus"/' \
        ~/.config/xsettingsd/xsettingsd.conf

    start xsettingsd

    # Polybar
    start polybar main --config=~/.config/polybar/config_light

    notify-send -c normal "Light theme has applied"
}

main() {
    if [ "$1" = "l" ]; then
        set_light
    elif [ "$1" = "d" ]; then
        set_dark
    else
        echo "l - light"
        echo "d - dark"
        exit 1
    fi
}

main "$@"
