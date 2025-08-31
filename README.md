# My System Configuration

A repo with dotfiles and other system configuration scripts that I use to bootstrap and maintain the working environment on my various systems.

## Setup

On any system, git needs to be installed so for cloning this repository. All other dependencies beyond that should be handled by the platform's corresponding init script.

### Windows

- In order to allow regular users to create symlinks, Developer Mode needs to be enabled in the Settings app.

```
curl -o init.bat https://raw.githubusercontent.com/https123456789/system/refs/heads/main/init.bat
init.bat
```
