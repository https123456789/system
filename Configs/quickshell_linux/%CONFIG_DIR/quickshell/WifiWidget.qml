import QtQuick
import Quickshell.Io

Text {
    id: root
    property bool hasWifi: false
    property bool hasEthernet: false
    property string wifiNetwork
    property string ethernetNetwork

    font.family: "DroidSansM Nerd Font"
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
    anchors.fill: parent
    color: Theme.text

    text: {
        let content = "";
        if (hasEthernet) {
            content += "󰈀  ";
        }
        if (hasEthernet && !hasWifi) {
            content += "Ethernet Connected";
        }
        if (hasWifi) {
            content += "  " + wifiNetwork;
        }
        if (!hasWifi && !hasEthernet) {
            content = "󰖪 No Internet";
        }

        content
    }

    Process {
        id: monitorProc
        running: true
        command: ["nmcli", "monitor"]

        stdout: SplitParser {
            onRead: (data) => {
                const getName = (input) => {
                    let first = input.indexOf("'");
                    let second = input
                        .split("")
                        .reverse()
                        .join("")
                        .indexOf("'");

                    if (first < 0 || second < 0) {
                        return "";
                    }

                    return input.substring(first, second + 1);
                };

                if (data.includes(":")) {
                    // There was a device-specific event
                    let is_eth_dev = data.includes("enp");
                    let is_wifi_dev = data.includes("wlp");
                    let is_unavailable = data.includes("unavailable");
                    let is_disconnected = data.includes("disconnected");
                    let is_connected = data.includes("connected") && !is_disconnected;

                    if (is_eth_dev && (is_unavailable || is_disconnected)) {
                        hasEthernet = false;
                        ethernetNetwork = "";
                    }
                    if (is_eth_dev && is_connected) {
                        hasEthernet = true;
                        networkInfoProc.running = true;
                    }

                    if (is_wifi_dev && (is_unavailable || is_disconnected)) {
                        hasWifi = false;
                        wifiNetwork = "";
                    }
                    if (is_wifi_dev && is_connected) {
                        hasWifi = true;
                        networkInfoProc.running = true;
                    }
                }
            }
        }
    }

    // Exists to initalize the state of the widget when it is created
    Process {
        id: networkInfoProc
        running: true
        command: ["nmcli", "-t", "-f", "NAME,TYPE,DEVICE", "connection", "show"]

        stdout: StdioCollector {
            onStreamFinished: {
                let entries = this.text.split("\n");
                for (let i = 0; i < entries.length; i++) {
                    let entry = entries[i];

                    if (entry == "") {
                        continue;
                    }
                    let [name, type, device] = entry.split(":");

                    if (device == "" || device == "lo") {
                        continue;
                    }

                    if (type.includes("wireless")) {
                        hasWifi = true;
                        wifiNetwork = name;
                    } else if (type.includes("ethernet")) {
                        hasEthernet = true;
                        ethernetNetwork = name;
                    }
                }
            }
        }
    }
}
