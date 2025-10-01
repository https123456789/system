$env.config.show_banner = false
$env.config.buffer_editor = "nvim"
$env.EDITOR = "nvim"

if $nu.os-info.name == "windows" {
    $env.CONFIG_DIR = $env.USERPROFILE + "/AppData/Roaming/"
    $env.LOCAL_CONFIG_DIR = $env.USERPROFILE + "/AppData/Local/"

    $env.PATH ++= [ "C:\\Program Files\\qemu" ]
} else {
    $env.CONFIG_DIR = $env.HOME + "/.config"

    # On unix systems, there is no need to differentiate between a "local" and "remote" config
    $env.LOCAL_CONFIG_DIR = $env.HOME + "/.config"

    $env.PATH ++= [ "~/.cargo/bin" ]
}

$env.PROMPT_COMMAND_RIGHT = date now | format date "%Y-%m-%d %H:%M"
