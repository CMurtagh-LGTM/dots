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
              WeatherPanel {
                Layout.fillWidth: true
                Layout.fillHeight: true
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

