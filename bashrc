#!/bin/bash

# Determine platform
platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
  platform='linux'
elif [[ "$unamestr" == 'Darwin' ]]; then
  platform='macos'
fi

# Source dotfiles 
if [ -f $HOME/.rc ]
then
  source $HOME/.rc
fi

# Use Cambridge colour palette for gnuplot
export GNUPLOT_LIB=$HOME/.gnuplot-files/cambridge.pal

# Source platform specific definitions
if [[ $platform == 'linux' ]]; then
  source $HOME/.bashrc-linux
elif [[ $platform == 'macos' ]]; then
  source $HOME/.bashrc-macos
fi

# Source bashrc local files 
# This contains local definitions which are not stored in the repository
if [ -f $HOME/.bashrc-local ]
then
  source $HOME/.bashrc-local
fi


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$($CONDA_EXE 'shell.bash' 'hook' 2> /dev/null)"
conda_bin=$(dirname $CONDA_EXE)
conda_path=$(dirname $conda_bin)
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$conda_path/etc/profile.d/conda.sh" ]; then
        . "$conda_path/etc/profile.d/conda.sh"
    else
        export PATH="$conda_bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

