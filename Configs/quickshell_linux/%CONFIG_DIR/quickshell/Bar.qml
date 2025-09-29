import Quickshell
import QtQuick
import QtQuick.Layouts

Scope {
    id: root

    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: window
            required property var modelData
            screen: modelData
            color: "transparent"

            property real radius: 13
            property real borderWidth: 2

            anchors {
                top: true
                left: true
                right: true
            }

            implicitHeight: 35

            RowLayout {
                anchors.fill: parent
                anchors.rightMargin: 2
                anchors.leftMargin: 2
                anchors.topMargin: 5
                anchors.bottomMargin: 5
                spacing: 6

                Rectangle {
                    Layout.preferredWidth: 250
                    Layout.fillHeight: true
                    radius: window.radius
                    color: Theme.base
                    border.color: Theme.border
                    border.width: window.borderWidth

                    ClockWidget {}
                }
                SpacerWidget {}
                Rectangle {
                    Layout.preferredWidth: 300
                    Layout.fillHeight: true
                    radius: window.radius
                    color: Theme.base
                    border.color: Theme.border
                    border.width: window.borderWidth

                    WifiWidget {}
                }
                Rectangle {
                    Layout.preferredWidth: 85
                    Layout.fillHeight: true
                    Layout.alignment: Qt.AlignRight
                    radius: window.radius
                    color: Theme.base
                    border.color: Theme.border
                    border.width: window.borderWidth

                    VolumeWidget {}
                }
                Rectangle {
                    Layout.preferredWidth: 85
                    Layout.fillHeight: true
                    Layout.alignment: Qt.AlignRight
                    radius: window.radius
                    color: Theme.base
                    border.color: Theme.border
                    border.width: window.borderWidth

                    BatteryWidget {}
                }
            }
        }
    }
}
