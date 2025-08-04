import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io

// TODO make buttons reuse code

Scope {
  Variants {
    model: Quickshell.screens

    PanelWindow {
      id: panel
      property var modelData
      screen: modelData
      visible: false

      implicitWidth: screen.width * 0.6
      implicitHeight: screen.height * 0.6

      color: "#00000000"

      RowLayout {
        anchors.fill: parent
        spacing: 5
        ColumnLayout {
          Media {
            Layout.fillWidth: true
            Layout.fillHeight: true
          }
          Sinks {
            Layout.fillWidth: true
          }
        }
        ColumnLayout{
          User {
            Layout.fillWidth: true
            Layout.fillHeight: true
          }
          Rectangle{ // TODO Weather and Calendar
            color: "{{bg2}}"
            Layout.fillWidth: true
            Layout.fillHeight: true
            radius: 5
            border {
              color: "{{bg_dim}}"
              width: 3
            }
          }
          Resource {
            Layout.fillWidth: true
            Layout.fillHeight: true
          }
        }
        Notifications {
          Layout.fillWidth: true
          Layout.fillHeight: true
        }
      }

      IpcHandler {
        target: "panel"

        function display(visible: bool): void { panel.visible = visible }
        function toggle(): void { panel.visible = !panel.visible }
      }
    }
  }
}
