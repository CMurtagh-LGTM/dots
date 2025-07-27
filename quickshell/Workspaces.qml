import Quickshell
import Quickshell.Hyprland
import QtQuick

Row {
    spacing: 0
    Repeater {
        model: ScriptModel {
            values: Hyprland.workspaces.values.filter(entry => !entry.name.startsWith("special:"))
        }
        Rectangle {
            required property HyprlandWorkspace modelData
            property HyprlandWorkspace workspace: modelData
            color: workspace.focused ? "{{bg_dim}}" : "{{bg2}}"

            width: 28 // 4 + 20 + 4
            height: 30

            Behavior on color {
                ColorAnimation { duration: 250 }
            }

            Text {
                text: ({
                        "special:Discord": "󰙯",
                        "special:Spotify": "󰓇", // TODO work out how to not display this
                        "Mail": "",
                        "Steam": "󰓓"
                    })[workspace.name] || workspace.name

                font.pixelSize: 16
                color: "{{fg}}"

                anchors.centerIn: parent
            }

            Rectangle {
                height: 3
                width: 28
                color: workspace.focused ? "{{fg}}" : mouse.containsMouse ? "{{fg}}" : "{{bg_dim}}"
                anchors.bottom: parent.bottom
                Behavior on color {
                    ColorAnimation { duration: 250 }
                }
            }

            MouseArea {
                id: mouse
                cursorShape: Qt.PointingHandCursor
                anchors.fill: parent
                hoverEnabled: true
                // onClicked: workspace.activate()
                onClicked: Hyprland.dispatch(`workspace ${workspace.name}`)
            }
        }
    }
}
