import QtQuick
import Quickshell

Scope {
  Variants {
    model: Quickshell.screens

    PanelWindow {
      property var modelData
      screen: modelData

      anchors {
        top: true
        left: true
        right: true
      }

      implicitHeight: 30

      color: "#00000000"

      Rectangle {
        height: 3
        width: parent.width
        anchors.bottom: parent.bottom
        color: "{{bg_dim}}"
      }

      Workspaces {
        anchors.left: parent.left
      }

      ClockWidget {
        anchors.horizontalCenter: parent.horizontalCenter
      }

      Tray {
        id: tray
        anchors.right: parent.right
      }
      Mpris {
        anchors.right: tray.left
      }
    }
  }
}
