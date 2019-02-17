#!/usr/env/bin python3

import os
from distutils.dir_util import copy_tree

# global vars
userhome = os.path.expanduser('~')
vim = userhome + "/.vim"
hueSrcDir = os.getcwd()
vimConfDir = vim

# dir create func
def create_dir(target_dir):
    if not os.path.exists(target_dir):
        os.makedirs(target_dir)
    else:
       os.system("Backed up existing " + vim + "dir")

def user_path():
    # print user's home directory
    print("User's home Dir: " + userhome)

    # print username by splitting path based on OS
    print("username: " + os.path.split(userhome)[-1])

    # ToDo: if vim dir exists backup and output bak loc

    # create user local vim dir
    # ToDo: create necessary dir structure for global vimConfDir
    create_dir(vim)
    print("User's vim dir: " + vim)

    # populate vimConfDir with hueSrcDir
    copy_tree(hueSrcDir, vimConfDir)

user_path()
