@echo OFF

set "dotfiles_dir=%USERPROFILE%\.dotfiles"

if exist "%dotfiles_dir%\" (
    echo Dotfiles directory already exists
) else (
    echo Cloning dotfiles
    git clone "https://github.com/https123456789/system" "%dotfiles_dir%"
)

echo Ensuring nushell is installed
winget install nushell --scope machine

cd "%dotfiles_dir%"
"C:\Program Files\nu\bin\nu.exe" "%dotfiles_dir%\init.nu"

pause
