#!/bin/bash

# Sourcing order: rc -> platform -> local. Local always wins.

# Determine platform
platform='unknown'
case "$(uname)" in
  Linux)  platform='linux' ;;
  Darwin) platform='macos' ;;
esac

# Cross-platform defaults
[ -f "$HOME/.rc" ] && . "$HOME/.rc"

# Platform-specific
if [ "$platform" = 'macos' ] && [ -f "$HOME/.bashrc-macos" ]; then
  . "$HOME/.bashrc-macos"
fi

# Machine-specific (not tracked in dotfiles)
[ -f "$HOME/.bashrc-local" ] && . "$HOME/.bashrc-local"
