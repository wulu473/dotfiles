#!/bin/bash

# Determine platform
platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
  platform='linux'
elif [[ "$unamestr" == 'Darwin' ]]; then
  platform='macos'
fi

# Setup crossplatform definitions


# Source platform specific definitions
if [[ $platform == 'linux' ]]; then
  source $HOME/.profile-linux
elif [[ $platform == 'macos' ]]; then
  source $HOME/.profile-macos
fi

# Source profile local files 
# This contains local definitions which are not stored in the repository
if [ -f $HOME/.profile-local ]
then
  source $HOME/.profile-local
fi

# added by Anaconda3 5.3.0 installer
# >>> conda init >>>
# !! Contents within this block are managed by 'conda init' !!
#__conda_setup="$(CONDA_REPORT_ERRORS=false '/anaconda3/bin/conda' shell.bash hook 2> /dev/null)"
#if [ $? -eq 0 ]; then
#    \eval "$__conda_setup"
#else
#    if [ -f "/anaconda3/etc/profile.d/conda.sh" ]; then
#        . "/anaconda3/etc/profile.d/conda.sh"
#        CONDA_CHANGEPS1=false conda activate base
#    else
#        \export PATH="/anaconda3/bin:$PATH"
#    fi
#fi
#unset __conda_setup
# <<< conda init <<<
