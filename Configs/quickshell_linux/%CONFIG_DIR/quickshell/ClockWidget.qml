import QtQuick
import '.'

Text {
    text: Time.time

    font.family: "DroidSansM Nerd Font"
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
    anchors.fill: parent
    color: Theme.text
}
