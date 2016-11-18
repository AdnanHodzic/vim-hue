#!/bin/bash
#
# Vim Hue Color scheme and Vim settings
# setup tool
#
# Copyleft: Adnan Hodzic <adnan@hodzic.org>
# License: GPLv3

separator(){
sep="\n-------------------------------------------------------------------"
echo -e $sep
}

# root check
root_check(){
if (( $EUID != 0 ));
then
	separator
	echo -e "\nMust be run as root (i.e: 'sudo $0')."
	separator
	exit 1
fi
}

# check if vim is installed/if not install?
#
# if 74 vs 8 different location completely

# debian/ubuntu vim74
deb_vim74="/usr/share/vim/vim74/colors"
deb_vim_conf="/etc/vim/vimrc.local"
deb_vim_conf_bak="/etc/vim/vimrc.local.org.bak"

# conf backup
if [ -f $deb_vim_conf ]
then
	echo "Found existing: $deb_vim_conf
	echo "Backup location: $deb_vim_conf_bak
	cp -f $deb_vim_conf $deb_vim_conf_bak
	echo ""
fi

# vim-hue conf
cp ./hue.vim $deb_vim74

# redhat/centos vim74
rh_vim74="/usr/share/vim/vim74/colors"
rh_vim_conf="/etc/vim/vimrc.local"

# mac vim74
mac_vim74="/usr/share/vim/vim74/colors"
mac_vim_conf="/usr/share/vim/vimrc"

# hue install:
#
# redhat family color install
# debian family color install
# mac install?

# vim config install
#
# options:
# only for user
# for all users

root_check
# exclude on mac?
