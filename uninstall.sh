#!/bin/zsh

if [[ -z "$ZSH_VERSION" ]]; then
    echo "❌ This script requires zsh. Run it as ./uninstall.sh, or: zsh uninstall.sh" >&2
    exit 1
fi

set -e

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
BIN_LINK="$HOME/.local/bin/mornin"
CONFIG_DIR="$HOME/.config/mornin"

echo "Uninstalling mornin..."
echo

# Remove the installed command, but only if it's actually ours
if [[ -L "$BIN_LINK" ]]; then
    target="$(readlink "$BIN_LINK")"

    if [[ "$target" == "$REPO_DIR/bin/mornin" ]]; then
        rm -f "$BIN_LINK"
        echo "Removed $BIN_LINK"
    else
        echo "⚠️  $BIN_LINK points elsewhere ($target) — leaving it alone"
    fi
elif [[ -e "$BIN_LINK" ]]; then
    echo "⚠️  $BIN_LINK exists but isn't a symlink — leaving it alone"
else
    echo "No installed command found at $BIN_LINK"
fi

echo

# Configuration is user data (your tracked repo list) — ask before deleting
if [[ -d "$CONFIG_DIR" ]]; then
    read "remove_config?Remove configuration at $CONFIG_DIR (your tracked repo list)? [y/N] " || remove_config=""

    if [[ "$remove_config" =~ ^[Yy]$ ]]; then
        rm -rf "$CONFIG_DIR"
        echo "Removed $CONFIG_DIR"
    else
        echo "Kept $CONFIG_DIR"
    fi
else
    echo "No configuration found at $CONFIG_DIR"
fi

echo
echo "ℹ️  Left ~/.local/bin on your PATH (in ~/.zprofile or ~/.zshrc) untouched —"
echo "   other tools may depend on it."
echo
echo "✅ mornin uninstalled."
