import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io

import qs.widgets

Scope {
  Variants {
    model: Quickshell.screens // TODO only current screen

    TransientWindow {
      property var modelData
      screen: modelData
      ipcTarget: "panel"
      widthRatio: 0.6
      heightRatio: 0.6
      component: Component {
        Rectangle {
          color: "transparent"
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
        }
      }
    }
  }
}

