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
git clone https://github.com/codecreative/mornin.git
cd mornin
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

Show this usage summary at any time:

```bash
mornin help
```

(`mornin -h` and `mornin --help` both work too.)

## Updating

Pull the latest version of `mornin` itself:

```bash
mornin update
```

This runs `git pull` in the clone you installed from. It fetches first, stops if that clone has uncommitted changes to tracked files and does nothing when you're already up to date. It needs the clone to still exist and have an upstream branch.

## Uninstallation

```bash
mornin uninstall
```

(Equivalent to running `./uninstall.sh` from wherever you cloned the repository — `mornin uninstall` just finds it for you.)

This removes the `mornin` command from `~/.local/bin` and asks before deleting your configuration at `~/.config/mornin` (your tracked repo list), since that's your data. It leaves `~/.local/bin` on your `PATH` alone, since other tools may depend on it being there.
