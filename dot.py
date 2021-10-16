#!/usr/bin/env python3

# ========== Imports ==========
import os, errno
from os.path import basename, isdir, isfile, islink, abspath, split
import sys
import shutil

try:
    from hooks import hooks
except:
    hooks = None


# ========== Colors ==========
class colors:
    HEADER = '\033[95m'
    BLUE = '\033[94m'
    GREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'

    def __init__(self):
        if os.isatty(sys.stdout.fileno()):
            self.disable()

    def disable(self):
        self.HEADER = ''
        self.BLUE = ''
        self.GREEN = ''
        self.WARNING = ''
        self.FAIL = ''
        self.ENDC = ''


def cprint(color, text):
    promt = colors.HEADER + '[dot] ' + colors.ENDC

    print(promt + color + text + colors.ENDC)


# ========== Functions ==========
def backup(path):
    m = path.replace(os.getenv('HOME'), '~', 1)
    cprint('WARNING', f'`{m}` exists. Creating backup')

    if not isdir('./backup'):
        os.mkdir('backup')

    try:
        # os.replace(path, abspath('./backup') + '/' + basename(path))
        shutil.copy(path, abspath('./backup') + '/' + basename(path))
        os.unlink(path)
    except OSError as e:
        cprint(colors.FAIL, f'{e}')


def get_dest(src):
    if src[0] == '@':
        return '/' + src[1:], True

    home = os.getenv('HOME')
    if home is None:
        cprint(colors.FAIL, "$HOME is unset. I can't find your home directory!")
        sys.exit(1)

    new = home + '/' + src

    return abspath(new), False


def install(src, dest, isRoot):
    cprint(colors.GREEN, f'installing {src} to {dest}')

    if (isdir(dest) or isfile(dest)) and (not islink(dest)):
        backup(dest)

    if isdir(dest) and not islink(dest):
        shutil.rmtree(dest)
    elif isfile(dest) and not islink(dest):
        os.remove(dest)
    elif islink(dest):
        cprint(colors.WARNING, f'`{src}` is already installed')
        return

    try:
        if isRoot:
            shutil.copy(abspath(src), dest)
        else:
            os.symlink(abspath(src), dest)
    except OSError as e:
        cprint(colors.FAIL, f'{e}')


def remove(path):
    cprint(colors.GREEN, f'removing {path}')

    try:
        os.unlink(path)
    except OSError as e:
        cprint(colors.FAIL, f'{e}')


def show():
    i = []
    n = []

    def add(src, dest):
        if islink(dest):
            if os.readlink(dest) == abspath(src):
                i.append(f'{src} -> {dest}')
        else:
            n.append(f'{src}')

    for root, dir, files in os.walk('.'):
        drop_dirs = ['.git', './backup', 'pycache']

        if any(d in root for d in drop_dirs):
            continue

        if root == '.':
            drop_files = ['.git', 'packages', 'dot.py', 'README', 'license', 'hooks.py']

            for f in files[:]:
                if any(d.lower() in f.lower() for d in drop_files):
                    files.remove(f)

            for f in files:
                dest, _ = get_dest(f)
                add(f, dest)

        if len(root.split('/')) <= 2 and root != '.':
            def sr(s, fd):
                if s[:2] == './':
                    s = s[2:]
                return s + '/' + fd

            for f in files:
                src = sr(root, f)
                dest, _ = get_dest(src)
                add(src, dest)
            for d in dir:
                src = sr(root, d)
                dest, _ = get_dest(src)
                add(src, dest)

    for dot in i:
        cprint(colors.GREEN, f'[x] {dot}')

    for dot in n:
        cprint(colors.BLUE, f'[ ] {dot}')


def run_hooks(src):
    try:
        command = hooks[src]
    except:
        return

    cprint(colors.GREEN, f'running hooks for {src}')
    try:
        command()
    except:
        cprint(colors.FAIL, f'hook for {src} is not a function!')


# ========== Main ==========
import argparse

parser = argparse.ArgumentParser(description='Super simple dotfile manager')
parser.add_argument('-i', '--install', nargs='+', help='install dotfiles')
parser.add_argument('-r', '--remove', nargs='+', help='remove dotfiles')
parser.add_argument('-H', '--hooks', action='store_true', help='run hooks')
parser.add_argument('-s', '--show', action='store_true', help='show installed dotfiles')

args = parser.parse_args()

if args.hooks and hooks is None:
    cprint(colors.FAIL, "hooks doesn't exist. Create it or remove `-H, --hooks` argument")
    sys.exit(1)

if args.install and args.remove:
    parser.print_help()

elif args.install:
    for dot in args.install:
        dest, isRoot = get_dest(dot)
        install(dot, dest, isRoot)

        if args.hooks:
            run_hooks(dot)

elif args.remove:
    for dot in args.remove:
        dest, isRoot = get_dest(dot)
        remove(dest)

elif args.show:
    show()

else:
    parser.print_help()
