# ALM (Appimage Linux Manager)

Alm is a lightweight Ruby CLI tool to manage AppImage files easily by adding or removing them from a user-local directory (`~/.local/appimage`). It automates permission granting and file moving without requiring root access, simplifying the handling of AppImages on Linux systems.

## Installation

You can install the gem from RubyGems after its release by running:

```bash
gem install alm
```

Or add it to your application's Gemfile with:

```bash
bundle add alm
```

## Usage

The alm command accepts two main flags:

- ``--add <file>`` - Adds an AppImage file by moving it to ~/.local/appimage, granting it executable permissions automatically.

- ``--remove <file>`` - Removes an AppImage file from the ~/.local/appimage directory.

## Notes

The tool creates the directory ``~/.local/appimage`` if it doesn't exist.

**No root (sudo) permissions are required** as long as the destination directory is writable by the user.

To run AppImages directly, consider adding ``~/.local/appimage`` to your system PATH:

```bash
export PATH="$HOME/.local/appimage:$PATH"
```

Add this line to your shell config (~/.bashrc, ~/.zshrc, etc.) to persist the change.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mvguest/alm.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT)
