#!/bin/zsh

# Load the colors module
autoload -U colors && colors

# Print each color with its name
for color in ${(k)fg}; do
    print -P "${fg[$color]}$color${reset_color}"
done

