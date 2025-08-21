$env.config.buffer_editor = "nvim"
$env.EDITOR = "nvim"

if $nu.os-info.name == "windows" {
    $env.CONFIG_DIR = $env.USERPROFILE + "/AppData/Roaming/"
    $env.LOCAL_CONFIG_DIR = $env.USERPROFILE + "/AppData/Local/"
} else {
    $env.CONFIG_DIR = $env.HOME + "/.config"

    # On unix systems, there is no need to differentiate between a "local" and "remote" config
    $env.LOCAL_CONFIG_DIR = $env.HOME + "/.config"
}
