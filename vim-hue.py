#!/usr/env/bin python3

import os
import shutil
import subprocess
import click
import sys
from subprocess import call
from distutils.dir_util import copy_tree
from sys import platform as _platform

# global vars
userhome = os.path.expanduser('~')
vim = userhome + "/.vim"
vimConfDir = vim
globalVim = "/etc/vim"
globalVimConfDir = globalVim
vimBakDir = vim + ".backup"
globalVimBakDir = globalVim + ".backup"
hueSrcDir = os.getcwd()

# dir vim (conf) dir func
def create_dir(target_dir):
    if not os.path.exists(target_dir):
        os.makedirs(target_dir)

def header():
    print("\n" + 35 * "-" + " vim-hue " + 35 * "-" + "\n")

def footer():
    print("\n" + 79 * "-" + "\n")

def vim_conf():
    print("\n" + 16 * "-" + " vim-hue - performing install for current user " + 16 * "-" + "\n")

    create_dir(vim)
    # necessary for overwrite if vimBakDir exists
    if os.path.exists(vimBakDir):
        shutil.rmtree(vimBakDir)
        print("Found and backed up existing Vim configuration:\n" + vimBakDir +  "\n")
        print("Performing vim-hue install for \"" + os.path.split(userhome)[-1] + "\" user")
        shutil.move(vim, vimBakDir)
    else:
        print("Found and backed up existing Vim configuration:\n" + vimBakDir)
        shutil.move(vim, vimBakDir)

    print("\nNew Vim (vim-hue) configuration stored in:\n" + vim)

    # populate vimConfDir with hueSrcDir
    copy_tree(hueSrcDir, vimConfDir)

def vim_conf_remove():
    print("\n" + 15 * "-" + " vim-hue - performing uninstall for current user " + 15 * "-" + "\n")

    if os.path.exists(vimBakDir):
        print("Found and restoring previously backed up Vim configuration:\n" + vimBakDir)
        shutil.rmtree(vim)
        shutil.move(vimBakDir, vim)
        print("\nNew Vim (vim-hue) configuration stored in:\n" + vim)
    else:
        print("No previously backed up Vim configuration found, restoring to defaults")
        shutil.rmtree(vim)
        if os.path.exists(vimBakDir):
            os.rmdir(vim)

    print("\nUninstall complete for \"" + os.path.split(userhome)[-1] + "\" user.")

def global_vim_conf():
    print("\n" + 11 * "-" + " vim-hue - performing system wide install for every user " + 11 * "-" + "\n")
    create_dir(globalVim)
    # necessary for overwrite if globalVimBakDir exists
    if os.path.exists(globalVimBakDir):
        shutil.rmtree(globalVimBakDir)
        print("Found and backed up existing Vim configuration:\n" + globalVimBakDir +  "\n")
        shutil.move(globalVim, globalVimBakDir)
    else:
        print("Found and backed up existing Vim configuration:\n" + globalVimBakDir)
        shutil.move(globalVim, globalVimBakDir)

    print("New Vim (vim-hue) configuration stored in:\n" + globalVim)

    # populate vimConfDir with hueSrcDir
    copy_tree(hueSrcDir, globalVimConfDir)

def global_vim_conf_remove():
    print("\n" + 10 * "-" + " vim-hue - performing system wide uninstall for every user " + 10 * "-" + "\n")

    if os.path.exists(globalVimBakDir):
        print("Found and restoring previously backed up Vim configuration:\n" + globalVimBakDir)
        shutil.rmtree(globalVim)
        shutil.move(globalVimBakDir, globalVim)
        print("\nNew Vim (vim-hue) configuration stored in:\n" + globalVim)
    else:
        print("No previously backed up Vim configuration found, restoring to defaults")
        shutil.rmtree(globalVim)
        if os.path.exists(globalVimBakDir):
            os.rmdir(globalVim)

    print("\nUninstall complete for all users (system wide).")

def vim_ver_check():
    getVimVer = subprocess.getoutput("vim --version | grep \"VIM - Vi IMproved\" | cut -d\" \" -f5 | grep -oE \"^\s*[0-9]+\"")
    vimVer = int(getVimVer)

    if (vimVer < 8 ):
        print("Only Vim version >= 8 are supported")
        quit()

def detect_linux():
    if _platform != "linux":
        print("\nError: system wide installation is only supported on Linux\n")
        quit()

def root_check():
    if os.geteuid() != 0:
        exit("\nMust be run as root (i.e: 'sudo python3 vim-hue.py').\n")

# cli
@click.command()
@click.option('--install', type=click.Choice(['user', 'system']), help='Install for current user or all users - system wide (Linux only)')
@click.option('--uninstall', type=click.Choice(['user', 'system']), help='Uninstall for current user or all users - system wide (Linux only)')

def cli(install, uninstall):
    # print --help by default if no argument is provided when vim-hue is run
    if len(sys.argv) == 1:
        header()
        print("vim-hue - colorful Vim config & theme for all your SRE/DevOps needs\n")
        print("\nExample usage: python3 vim-hue.py --install user\n")
        print("-----\n")

        call(["python3", "vim-hue.py", "--help"])
        footer()
    else:
        if install == "user":
            vim_ver_check()
            vim_conf()
        elif install == "system":
            vim_ver_check()
            detect_linux()
            root_check()
            global_vim_conf()
        elif uninstall == "user":
            vim_ver_check()
            vim_conf_remove()
        elif uninstall == "system":
            vim_ver_check()
            detect_linux()
            root_check()
            global_vim_conf_remove()
        footer()

if __name__ == '__main__':
    cli()
