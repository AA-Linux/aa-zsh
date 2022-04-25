#!/usr/bin/env bash

install_zsh() {
    echo -e "\e[0;32m+---What configuration you want install?---+\e[0m\n"
    echo -e "\e[0;32m 1 - oh my zsh\e[0m\n"
    echo -e "\e[0;32m 2 - zsh with out plugins\e[0m\n"
    echo -e "\n\e[0;32m Choose just one: \e[0m"
    read res
    if [[ $res == "1" ]]; then
        bash `pwd`/oh-my-zsh/setup.sh
    elif [[ $res == "2" ]]; then
        bash `pwd`/zsh/setup.sh
    fi
    echo -e "\e[0;32m+-----------------Finished!----------------+\e[0m"
}
install_zsh
