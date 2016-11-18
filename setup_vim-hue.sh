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

# make sure vim is installed
#
# if 74 vs 8 different location completely
#
# make config backups

# ubuntu/debian 74
# /usr/share/vim/vim74/colors
#
# config:
# /etc/vim/vimrc.local
#
#
# centos/redhat 74
# /usr/share/vim/vim74/colors
#
# config:
# /etc/vimrc
#
# mac
# /usr/share/vim/vim72/colors
#
# config:
# /usr/share/vim/vimrc

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
