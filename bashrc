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

