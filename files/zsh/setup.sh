#!/bin/bash

shopt -s extglob

usage() {
    cat <<EOF

usage: ${0##*/} [flag] or [option]

    options:

    --version, -v            View installer version
    --install, -i            Start installation
    --uninstall, -u          Remove zsh from your machine

EOF
}

if [[ -z $1 || $1 = @(-h| --help) ]];then
    usage
    exit $(( $# ? 0 : 1 ))
fi

version="${0##*/} version 1.0.3"

set_install() {
    echo -e "\e[1;32m * Downloading ZSH in your machine \e[0m"
    sudo pacman -S zsh
    echo -e "\e[1;33m * Make zsh with default shell:\e[0m "
    chsh -s $(which zsh)
    echo -e "\e[1;33m * Done! zsh is your shell default\e[0m"

    mkdir ~/.config/zsh ; rm ~/.zshrc ; touch ~/.zshrc

    echo "export ZDOTDIR=$HOME/.config/zsh" >> ~/.zshrc
    echo "source "$HOME/.config/zsh/.zshrc"" >> ~/.zshrc

    mv ./zsh-prompt ~/.config/zsh/
    mv ./zsh-aliases ~/.config/zsh/
    mv ./zsh-exports ~/.config/zsh/
    mv ./zsh-vim-mode ~/.config/zsh/
    mv ./zsh-functions ~/.config/zsh/
    mv ./.gitignore ~/.config/zsh/
    mv ./.zshrc ~/.config/zsh/

    asdf_install() {
        clear
        echo -e "\e[1;33mDo you want to install asdf? [Y/n] \e[0m"
        read reply

        if [[ ${reply,,[A-Z]} == "y" ]];then
            echo -e "\e[1;32m install asdf...\e[0m"
            cd /tmp
            git clone https://aur.archlinux.org/asdf-vm.git ; cd asdf-vm ; makepkg -si
            sed -i 's/#. \/opt.*/. \/opt\/asdf-vm\/asdf.sh/g' ~/.config/zsh/zsh-exports
        else
            return 0
        fi
    }
    asdf_install
    sudo pacman -S --noconfirm zoxide fzf

    echo -e "\e[1;32m Done! \e[0m"
}

set_uninstall() {
    echo -e "\e[1;132m;-; Removed ZSH...\e[0m"
    rm -rf ~/.config/zsh ; rm ~/.zshrc ; rm ~/.zsh_history
    echo -e "\e[1;32m Change to Bash \e[0m"
    chsh -s /bin/bash
    clear
    echo -e "\e[1;132m Done! \e[0m"
}

case "$1" in

    "--version"|"-v") echo $version ;;
    "--install"|"-i") set_install ;;
    "--uninstall"|"-u") set_uninstall ;;
    *) echo -e "\e[0;31m* Invalid Option\e[0m" ;;

esac

exit 0

