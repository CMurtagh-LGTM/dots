import Quickshell
import Quickshell.Hyprland
import QtQuick

Row {
    spacing: 0
    Repeater {
        model: Hyprland.workspaces
        Rectangle {
            required property HyprlandWorkspace modelData
            property HyprlandWorkspace workspace: modelData
            color: workspace.focused ? "{{bg_dim}}" : "{{bg2}}"

            width: 28 // 4 + 20 + 4
            height: 30

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
