import QtQuick
import Quickshell

import qs.services
import qs.widgets

Scope {
  Variants {
    model: Quickshell.screens // TODO only current screen

    TransientWindow {
      id: root
      property var modelData
      screen: modelData
      namespace: "shell:launcher"
      ipcTarget: "wiktionary"
      widthRatio: 0.3
      heightRatio: 0.6

      component: Component {
        Rectangle {
          color: "{{bg2}}"
          radius: 5
          border {
            color: "{{bg_dim}}"
            width: 3
          }
          Text {
            text: Wiktionary.page("test");
          }
        }
      }
    }
  }
}
