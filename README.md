# mornin ☀️

A small macOS/Zsh utility for checking and optionally updating a collection of Git repositories.

`mornin` checks your repositories, tells you which ones have remote changes, and asks before pulling them.

## Features

- Checks multiple Git repositories
- Fetches remote state before deciding whether an update is available
- Shows repositories that are ahead of or behind their remote
- Detects uncommitted changes
- Never pulls a repository with uncommitted changes
- Asks for confirmation before pulling
- Uses your existing Git authentication
- Keeps machine-specific configuration outside the Git repository
- `mornin add`, `mornin remove`, and `mornin list` manage the config file without hand-editing it

## Requirements

- macOS
- Zsh
- Git

Git is normally already available on macOS.

## Installation

Clone the repository:

```bash
git clone <REPOSITORY_URL> ~/projects/mornin
cd ~/projects/mornin
./install.sh
```

## Usage

Check all tracked repositories and optionally pull the ones that are behind:

```bash
mornin
```

Add a repository to the config:

```bash
mornin add ~/projects/new-project
```

Remove a repository from the config:

```bash
mornin remove ~/projects/old-project
```

List tracked repositories (`ls` works too), flagging any that are missing or no longer a Git repository. This is a local-only check — it doesn't fetch:

```bash
mornin list
```

Run `mornin add` or `mornin remove` with no arguments from inside a repository to target the current directory. `add` requires the path to be an existing Git repository and ignores duplicates. `remove` matches by resolved path (so it works regardless of whether the entry is stored with `~` or as an absolute path) and also works on stale entries whose directory no longer exists.
