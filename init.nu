def pstatus [message] {
    print $"[(ansi teal)INFO(ansi reset)] ($message)"
}

def pwarn [message] {
    print $"[(ansi orange)WARN(ansi reset)] ($message)"
}

def pfail [message] {
    print $"[(ansi red)FAIL(ansi reset)] ($message)"
}

def protected_run [command expected_codes err_msg] {
    print $"[(ansi purple)RUN (ansi reset)] ($command)"
    do -i {
        nu -c $command
    }
    let result = $env.LAST_EXIT_CODE

    if $result not-in $expected_codes {
        pfail $err_msg
        exit 1
    }
}

pstatus "Running main init script"

# Install the minimum number of dependencies needed to get tuckr and metapac installed

if $nu.os-info.family == "windows" {
    pstatus "Windows system detected"

    # This needs to happen as soon as possible so that `protected_run` functions properly
    $env.PATH ++= [ "~/.cargo/bin", "C:/Program Files/nu/bin" ]

    pstatus "Installing MSVC"
    protected_run "winget install --force --id=Microsoft.VisualStudio.2022.BuildTools -e" [0] "Failed to install MSVC!"
    let vs_cmd = 'winget install Microsoft.VisualStudio.2022.Community --silent --override "--wait --add Microsoft.VisualStudio.Workload.NativeDesktop --includeRecommended"'
    # protected_run $vs_cmd [0] "Failed to install MSVC!"

    pstatus "Installing rustup"
    protected_run "winget install --force --id=Rustlang.Rustup -e" [0, -1978335189] "Failed to install rustup!"

    let paths_cmd = r#'reg add "HKLM\\SYSTEM\\CurrentControlSet\\Control\\FileSystem" /v LongPathsEnabled /t REG_DWORD /d 1 /f'#
    protected_run $paths_cmd [0] "Failed to configure long paths!"
} else if $nu.os-info.name == "linux" {
    pstatus "Linux system detected"

    $env.PATH ++= [ "~/.cargo/bin" ]

    pstatus "Installing rustup"
    protected_run "sudo pacman -S --needed --noconfirm rustup" [0] "Failed to install rustup!"

    $env.CONFIG_DIR = ($env | get --optional XDG_CONFIG_DIR | default "~/.config")
    $env.LOCAL_CONFIG_DIR = ($env | get --optional XDG_CONFIG_DIR | default "~/.config")

    protected_run $"sudo chsh -s /usr/bin/nu (^whoami)" [0] "Failed to change default shell!"

    protected_run "sudo groupadd --system uinput" [0] "Failed to create uinput group!"
    protected_run $"sudo usermod -aG adm (^whoami)" [0] "Failed to add group!"
    protected_run $"sudo usermod -aG uucp (^whoami)" [0] "Failed to add group!"
    protected_run $"sudo usermod -aG input (^whoami)" [0] "Failed to add group!"
    protected_run $"sudo usermod -aG uinput (^whoami)" [0] "Failed to add group!"
} else {
    pfail "Unsupported platform!"
    exit 1
}

pstatus "Defaulting to stable rust toolchain"
protected_run "rustup default stable" [0] "Failed to set default rust toolchain!"

pstatus "Installing tuckr"
protected_run "cargo install --git https://github.com/RaphGL/Tuckr" [0] "Failed to install Tuckr!"

pstatus "Installing metapac"
protected_run "cargo install metapac" [0] "Failed to install metapac!"

# Source the nushell config to give us the environment variables we need

source ~/.dotfiles/Configs/nushell/%CONFIG_DIR/nushell/config.nu

# Basic environment

protected_run "tuckr status" [0] "Failed basic tuckr sanity check!"
protected_run "tuckr set nushell" [0] "Failed to setup nushell config!"
protected_run "tuckr set metapac" [0] "Failed to setup metapac config!"
protected_run "tuckr set git" [0] "Failed to setup git config!"

if $nu.os-info.name == "linux" {
  protected_run "tuckr set --force --assume-yes hyprland_linux" [0] "Failed to setup hyprland!"
}

protected_run "cd Configs; tuckr set *" [0] "Failed to setup git config!"

# Install the universe

protected_run "metapac sync -n" [0] "Failed to sync installed packages!"
