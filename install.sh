#!/usr/bin/env bash
set -euo pipefail

for item in ./*; do
    package=$(basename $item)
    if [ -d "$package" ]; then
        stow --verbose --restow $package
    fi
done

