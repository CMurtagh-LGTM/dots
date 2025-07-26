import QtQuick
import Quickshell
import Quickshell.Io

Scope {
  Variants {
    model: Quickshell.screens

    PanelWindow {
      id: launcher
      property var modelData
      screen: modelData
      visible: false
      focusable: true

      Text {
        text: "hi"
      }

      IpcHandler {
        target: "launcher"

        function display(visible: bool): void { launcher.visible = visible }
      }
    }
  }
}
