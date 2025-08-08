# Notes

## Setup

On any system, [`metapack`](https://github.com/ripytide/metapac) and [`chezmoi`](https://www.chezmoi.io) need to be installed.

## Windows

- In order to allow regular users to create symlinks, Developer Mode needs to be enabled in the Settings app.
- Enable long paths:
  ```
  Set-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem' -Name 'LongPathsEnabled' -Value 1
  ```
