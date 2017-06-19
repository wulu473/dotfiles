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

