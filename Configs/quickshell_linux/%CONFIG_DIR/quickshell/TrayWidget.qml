import QtQuick
import Quickshell
import Quickshell.Services.SystemTray

Scope {
    Repeater {
        model: SystemTray.items

        delegate: Image {
            source: model.icon
        }
    }
}
