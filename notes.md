# Notes

## Setup

On any system, git needs to be installed so for cloning this repository. All other dependencies beyond that should be handled by the platform's corresponding init script.

## Windows

- In order to allow regular users to create symlinks, Developer Mode needs to be enabled in the Settings app.
- Enable long paths:
  ```
  Set-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem' -Name 'LongPathsEnabled' -Value 1
  ```
