#!/usr/bin/env bash
set -euo pipefail


stow_packages()
{
    stow_cmd=${1:-restow}

    for item in ./*; do
        package=$(basename $item)
        if [ -d "$package" ]; then
            stow --verbose "--$stow_cmd" $package
        fi
    done
}

action=${1:-}
case "$action" in
    stow|restow|delete)
        echo "Apllying $action to all packages..."
        stow_packages $action
        ;;
    *)
        echo "ERROR: Provide action '$action' is not valid."
        ;;
esac
