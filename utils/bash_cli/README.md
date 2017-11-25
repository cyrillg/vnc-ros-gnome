# CLI for the Serial Robotics docker environment

## Installation

From the `cli/` folder run: `sudo ./cli install sr-cli`
This will:
* allow you to call the CLI from any location in your filesystem (adds a symlink
* to the `cli` script in `/usr/bin`)
* setup the auto-completion (copies the `complete` script in
* `/etc/bash_completion.d/`).

_**Note**: If you wish to give another name to your CLI, you simply need to run
`sudo ./cli install YOUR_NAME_HERE` instead._

## Use

By simply running `sr-cli` you can visualize all available commands with a short
description.

## Unistall

From the `cli/` folder run: `sudo ./cli uninstall sr-cli`
This will remove the two files created during the installation step.

## Credits

This tool is based on the very helpful _Bash CLI_ framework by SierraSoftworks,
available at https://github.com/SierraSoftworks/bash-cli.
