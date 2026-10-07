#!/bin/zsh

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
    if ! grep -Fq "$PATH_LINE" "$HOME/.zshrc" 2>/dev/null; then
        echo "$PATH_LINE" >> "$HOME/.zshrc"
        echo "Added ~/.local/bin to ~/.zshrc"
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
