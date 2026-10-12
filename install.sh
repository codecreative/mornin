#!/bin/zsh

if [[ -z "$ZSH_VERSION" ]]; then
    echo "❌ This script requires zsh. Run it as ./install.sh, or: zsh install.sh" >&2
    exit 1
fi

set -e

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Installing mornin..."
echo

# Create required directories
mkdir -p "$HOME/.local/bin"
mkdir -p "$HOME/.config/mornin"

# Link the executable into ~/.local/bin
ln -sf "$REPO_DIR/bin/mornin" "$HOME/.local/bin/mornin"

# Create the configuration if it doesn't already exist
if [[ ! -f "$HOME/.config/mornin/repos" ]]; then
    cp "$REPO_DIR/config/repos.example" "$HOME/.config/mornin/repos"
    echo "Created ~/.config/mornin/repos"
else
    echo "Existing ~/.config/mornin/repos preserved"
fi

# Add ~/.local/bin to PATH if necessary
PATH_LINE='export PATH="$HOME/.local/bin:$PATH"'

if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    already_configured=0

    for rcfile in "$HOME/.zprofile" "$HOME/.zshrc"; do
        if [[ -f "$rcfile" ]] && grep -Fq "$PATH_LINE" "$rcfile" 2>/dev/null; then
            already_configured=1
            break
        fi
    done

    if (( ! already_configured )); then
        echo "mornin needs ~/.local/bin on your PATH to work in new terminal sessions."
        read "add_path?Add it to ~/.zprofile now? [y/N] " || add_path=""

        if [[ "$add_path" =~ ^[Yy]$ ]]; then
            if { echo "$PATH_LINE" >> "$HOME/.zprofile"; } 2>/dev/null; then
                echo "Added ~/.local/bin to ~/.zprofile"
            else
                echo "⚠️  Couldn't write to ~/.zprofile (check permissions)."
                echo "Add this to your shell profile manually:"
                echo "  $PATH_LINE"
            fi
        else
            echo "Skipped. Add this to your shell profile manually:"
            echo "  $PATH_LINE"
        fi
    fi

    export PATH="$HOME/.local/bin:$PATH"
fi

echo
echo "✅ mornin installed successfully."
echo
echo "Installed command:"
echo "  ~/.local/bin/mornin"
echo
echo "Configuration:"
echo "  ~/.config/mornin/repos"
echo
echo "Usage:"
echo "  mornin                 Check tracked repositories and pull if needed"
echo "  mornin add [path]      Track a repository (defaults to the current directory)"
echo "  mornin remove [path]   Stop tracking a repository"
echo "  mornin list            List tracked repositories (alias: ls)"
echo "  mornin update          Pull the latest version of mornin itself"
echo "  mornin uninstall       Remove the mornin command (asks before deleting config)"
echo "  mornin help            Show usage (aliases: -h, --help)"
