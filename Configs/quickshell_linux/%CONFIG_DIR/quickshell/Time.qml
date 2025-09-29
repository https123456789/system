pragma Singleton

import Quickshell
import QtQuick

Singleton {
    readonly property string time: {
        Qt.formatDateTime(clock.date, "ddd MMM d yyyy hh:mm")
    }

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }
}
