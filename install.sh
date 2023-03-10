#!/bin/bash

# refer  k-vim https://github.com/wklken/k-vim`
BASEDIR=$(dirname $0)
cd $BASEDIR
CURRENT_DIR=`pwd`

lnif() {
    if [ -e "$1" ]; then
        ln -sf "$1" "$2"
    fi
}


echo "Step1: backing up current vim config"
today=`date +%Y%m%d`
for i in $HOME/.vim $HOME/.vimrc $HOME/.gvimrc $HOME/.vimrc.bundles; do [ -e $i ] && [ ! -L $i ] && mv $i $i.$today; done
for i in $HOME/.vim $HOME/.vimrc $HOME/.gvimrc $HOME/.vimrc.bundles; do [ -L $i ] && unlink $i ; done


echo "Step2: setting up symlinks"
lnif $CURRENT_DIR/vimrc $HOME/.vimrc
#lnif $CURRENT_DIR/vimrc.bundles $HOME/.vimrc.bundles
lnif "$CURRENT_DIR/vim" "$HOME/.vim"


echo "Step3: update/install plugins using Vundle"
system_shell=$SHELL
export SHELL="/bin/sh"
# vim -u $HOME/.vimrc +PlugInstall! +PlugClean! +qall
vim +PluginInstall +qall
export SHELL=$system_shell


echo "Step4: compile YouCompleteMe"
echo "It will take a long time, just be patient!"
echo "If error,you need to compile it yourself"
echo "cd $CURRENT_DIR/vim/bundle/YouCompleteMe/ && python3 install.py --clang-completer"
cd $CURRENT_DIR/vim/bundle/YouCompleteMe/
youcompleteme_clang_complete=""
# youcompleteme_clang_complete="--clang-completer"
git submodule update --init --recursive
if [ `which clang` ]   # check system clang
then
    # python install.py --clang-completer --system-libclang   # use system clang
    python3 install.py    # use system clang
else
    # python install.py --clang-completer
    python3 install.py
fi

echo "Install Done!"
