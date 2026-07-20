# dotfiles

Personal shell, terminal, editor, and window-manager configuration.

Run `./setup.sh` to install the command-line dependencies and link the managed
files into `$HOME`. Existing targets are preserved with a timestamped `.backup`
suffix before a link is created.

The editor configurations are intentionally separate: VS Code and Cursor share
most navigation conventions but retain application-specific settings and
themes.
