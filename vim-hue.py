#!/usr/env/bin python3

import os
import shutil
import subprocess
from distutils.dir_util import copy_tree

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

def vim_conf():
    # ToDo:
    # - create options menu
    # - create necessary ops + dir structure for global vimConfDir
    # - for global config make root check
    print("\n" + 20 * "-" + " vim-hue " + 20 * "-" + "\n")

    create_dir(vim)
    # necessary for overwrite if vimBakDir exists
    if os.path.exists(vimBakDir):
        shutil.rmtree(vimBakDir)
        print("Found and backed up existing Vim configuration:\n" + vimBakDir +  "\n")
        shutil.move(vim, vimBakDir)
    else:
        print("Found and backed up existing Vim configuration:\n" + vimBakDir)
        shutil.move(vim, vimBakDir)

    print("\nNew Vim (vim-hue) configuration stored in:\n" + vim)
    print("\n" + 49 * "-" + "\n")

    # populate vimConfDir with hueSrcDir
    copy_tree(hueSrcDir, vimConfDir)

def global_vim_conf():
    print("\n" + 20 * "-" + " vim-hue " + 20 * "-" + "\n")
    #root check

    create_dir(globalVim)
    # necessary for overwrite if globalVimBakDir exists
    if os.path.exists(globalVimBakDir):
        shutil.rmtree(globalVimBakDir)
        print("Found and backed up existing Vim configuration:\n" + globalVimBakDir +  "\n")
        shutil.move(globalVim, globalVimBakDir)
    else:
        print("Found and backed up existing Vim configuration:\n" + globalVimBakDir)
        shutil.move(globalVim, globalVimBakDir)

    print("\nNew Vim (vim-hue) configuration stored in:\n" + globalVim)
    print("\n" + 49 * "-" + "\n")

    # populate vimConfDir with hueSrcDir
    copy_tree(hueSrcDir, globalVimConfDir)

def vim_ver_check():
    getVimVer = subprocess.getoutput("vim --version | grep \"VIM - Vi IMproved\" | cut -d\" \" -f5 | grep -oE \"^\s*[0-9]+\"")
    vimVer = int(getVimVer)

    if (vimVer < 8 ):
        print("Only Vim version >= 8 are supported")
        quit()

vim_ver_check()
# ToDo:
# Add to options menu
#vim_conf()
#global_vim_conf()
