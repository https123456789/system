import QtQuick
import Quickshell.Hyprland

Text {
    text: Hyprland.focusedWorkspace.id

    font.family: "DroidSansM Nerd Font"
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
    anchors.fill: parent
    color: Theme.text
}
