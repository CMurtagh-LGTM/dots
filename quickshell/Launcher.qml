import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland

import qs.widgets

Scope {
  Variants {
    model: Quickshell.screens // TODO only current screen

    TransientWindow {
      property var modelData
      screen: modelData
      namespace: "shell:launcher"
      ipcTarget: "launcher"
      widthRatio: 0.3
      heightRatio: 0.6
      component: Component {
        Rectangle {
          color: "{{bg2}}"
          Text { text: "hi" }
        }
      }
    }
  }
}
