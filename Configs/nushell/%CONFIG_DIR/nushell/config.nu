$env.config.show_banner = false
$env.config.buffer_editor = "nvim"
$env.EDITOR = "nvim"
$env.LANG = "en_US.UTF-8"

if $nu.os-info.name == "windows" {
    $env.CONFIG_DIR = $env.USERPROFILE + "/AppData/Roaming/"
    $env.LOCAL_CONFIG_DIR = $env.USERPROFILE + "/AppData/Local/"

    $env.PATH ++= [ "C:\\Program Files\\qemu" ]
} else {
    $env.CONFIG_DIR = $env.HOME + "/.config"

    # On unix systems, there is no need to differentiate between a "local" and "remote" config
    $env.LOCAL_CONFIG_DIR = $env.HOME + "/.config"

    $env.PATH ++= [
      "~/.cargo/bin",
      "~/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin/",
      "/nix/var/nix/profiles/default/bin",
      "~/.local/state/nix/profiles/profile/bin"
    ]
}

let is_nix_shell = $env | get --optional name | is-not-empty
let old_prompt_command = $env.PROMPT_COMMAND
$env.AAA = $old_prompt_command

$env.PROMPT_COMMAND = {||
  if $is_nix_shell {
    "(Nix) " + (do $old_prompt_command)
  } else {
    do $old_prompt_command
  }
}
$env.PROMPT_COMMAND_RIGHT = date now | format date "%Y-%m-%d %H:%M"

# Direnv
$env.config.hooks.env_change.PWD = [{ ||
  if (which direnv | is-empty) {
    return
  }

  direnv export json | from json | default {} | load-env
  # Direnv outputs $PATH as a string, but nushell silently breaks if isn't a list-like table.
  # The following behemoth of Nu code turns this into nu's format while following the standards of how to handle quotes, use it if you need quote handling instead of the line below it:
  # $env.PATH = $env.PATH | parse --regex ('' + `((?:(?:"(?:(?:\\[\\"])|.)*?")|(?:'.*?')|[^` + (char env_sep) + `]*)*)`) | each {|x| $x.capture0 | parse --regex `(?:"((?:(?:\\"|.))*?)")|(?:'(.*?)')|([^'"]*)` | each {|y| if ($y.capture0 != "") { $y.capture0 | str replace -ar `\\([\\"])` `$1` } else if ($y.capture1 != "") { $y.capture1 } else $y.capture2 } | str join }
  $env.PATH = $env.PATH | split row (char env_sep)
}]
