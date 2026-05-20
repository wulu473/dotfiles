#!/bin/bash

# Login shell entry point.
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
if [ "$platform" = 'macos' ] && [ -f "$HOME/.profile-macos" ]; then
  . "$HOME/.profile-macos"
fi

# Machine-specific (not tracked in dotfiles)
[ -f "$HOME/.profile-local" ] && . "$HOME/.profile-local"
