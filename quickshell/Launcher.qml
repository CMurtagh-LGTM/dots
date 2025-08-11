pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Widgets

import qs.widgets

Scope {
  Variants {
    model: Quickshell.screens // TODO only current screen

    TransientWindow {
      id: root
      property var modelData
      screen: modelData
      namespace: "shell:launcher"
      ipcTarget: "launcher"
      widthRatio: 0.3
      heightRatio: 0.6

      Connections {
        target: root.persist

        function onOpenChanged(): void {
          if (root.persist.open) {
            search.focus = true // TODO fix reference error
          }
        }
      }

      component: Component {
        ClippingRectangle {
          color: "{{bg2}}"
          radius: 5
          border {
            color: "{{bg_dim}}"
            width: 3
          }
          Column {
            anchors.fill: parent
            Rectangle {
              id: prompt
              anchors.left: parent.left
              anchors.right: parent.right
              implicitHeight: promptText.contentHeight
              color: "{{bg3}}"
              RowLayout {
                anchors.fill: parent
                Text {
                  id: promptText
                  color: "{{fg}}"
                  text: ">"
                }
                TextField {
                  id: search
                  color: "{{fg}}"
                  placeholderTextColor: color
                  Layout.fillWidth: true
                  Layout.fillHeight: true
                  //cursorVisible: false
                  placeholderText: "App"
                  background: Rectangle { color: "transparent" }
                }
              }
            }
            Flickable {
              anchors.top: prompt.bottom
              anchors.bottom: parent.bottom
              anchors.left: parent.left
              anchors.right: parent.right
              anchors.margins: 3
              contentWidth: width
              contentHeight: column.height
              boundsBehavior: Flickable.StopAtBounds
              clip: true
              ColumnLayout {
                id: column
                anchors.left: parent.left
                anchors.right: parent.right
                Repeater {
                  model: DesktopEntries.applications.values
                  Item {
                    Layout.fillWidth: true
                    Layout.minimumHeight: 25
                    required property DesktopEntry modelData
                    property DesktopEntry application: modelData
                    Text {
                      color: "{{fg}}"
                      text: application.name
                    }
                  }
                }
              }
              ScrollBar.vertical: ScrollBar { }
            }
          }
        }
      }
    }
  }
}
