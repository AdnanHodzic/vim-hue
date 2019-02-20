#!/usr/env/bin python3

import os
import shutil
import subprocess
from distutils.dir_util import copy_tree

# global vars
userhome = os.path.expanduser('~')
vim = userhome + "/.vim"
vimBakDir = vim + ".backup"
hueSrcDir = os.getcwd()
vimConfDir = vim

# dir vim (conf) dir func
def create_vim_dir(target_dir):
    if not os.path.exists(target_dir):
        os.makedirs(target_dir)
    elif os.path.exists(target_dir):
        # necessary for overwrite if vimBakDir exists
        if os.path.exists(vimBakDir):
            shutil.rmtree(vimBakDir)
            print("Found and backed up existing Vim configuration:\n" + vimBakDir +  "\n")
            shutil.move(vim, vimBakDir)
        else:
            print("Found and backed up existing Vim configuration:\n" + vimBakDir)
            shutil.move(vim, vimBakDir)

def vim_conf():
    # ToDo:
    # - create options menu
    # - create necessary ops + dir structure for global vimConfDir
    # - for global config make root check
    print("\n" + 20 * "-" + " vim-hue " + 20 * "-" + "\n")
    create_vim_dir(vim)
    print("New Vim (vim-hue) configuration stored in:\n" + vim)
    print("\n" + 49 * "-" + "\n")
    # populate vimConfDir with hueSrcDir
    copy_tree(hueSrcDir, vimConfDir)

def vim_ver_check():
    getVimVer = subprocess.getoutput("vim --version | grep \"VIM - Vi IMproved\" | cut -d\" \" -f5 | grep -oE \"^\s*[0-9]+\"")
    vimVer = int(getVimVer)

    if (vimVer < 8 ):
        print("Only Vim version >= 8 are supported")
        quit()

#vim_conf()
vim_ver_check()
