import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io

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
        Sinks {
          Layout.alignment: Qt.AlignTop
          Layout.fillWidth: true
          Layout.fillHeight: true
        }
        ColumnLayout{
          User {
            Layout.fillWidth: true
            Layout.fillHeight: true
          }
          Resource {
            Layout.fillWidth: true
            Layout.fillHeight: true
          }
        }
        Rectangle{
          color: "{{bg2}}"
          Layout.fillWidth: true
          Layout.fillHeight: true
          radius: 5
          border {
            color: "{{bg_dim}}"
            width: 3
          }
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
