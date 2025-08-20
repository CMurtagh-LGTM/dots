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

      component: Component {
        ClippingRectangle {
          color: "{{bg2}}"
          radius: 5
          border {
            color: "{{bg_dim}}"
            width: 3
          }
          Keys.onPressed: (event) => {
            if (event.key == Qt.Key_Return) { list.currentItem.application.execute(); persist.open = false; }
            if (event.key == Qt.Key_Down) { list.incrementCurrentIndex(); }
            if (event.key == Qt.Key_Up) { list.decrementCurrentIndex(); }
          }
          Column {
            anchors.fill: parent
            Rectangle {
              id: prompt
              anchors.left: parent.left
              anchors.right: parent.right
              implicitHeight: 32 
              color: "{{bg3}}"
              RowLayout {
                anchors.fill: parent
                Text {
                  id: promptText
                  color: "{{fg}}"
                  text: ">"
                  Layout.alignment: Qt.AlignHCenter
                  Layout.leftMargin: 10
                }
                TextField {
                  id: search
                  color: "{{fg}}"
                  placeholderTextColor: color
                  Layout.fillWidth: true
                  Layout.alignment: Qt.AlignHCenter
                  cursorVisible: false
                  placeholderText: "App"
                  background: Rectangle { color: "transparent" }
                  Component.onCompleted: forceActiveFocus()
                }
              }
            }
            ListView {
              id: list
              model: ScriptModel {
                values: FzyFinder.filter(search.text, DesktopEntries.applications.values, "name");
              }

              anchors.top: prompt.bottom
              anchors.bottom: parent.bottom
              anchors.left: parent.left
              anchors.right: parent.right
              anchors.margins: 3
              clip: true
              boundsBehavior: Flickable.StopAtBounds
              currentIndex: 0
              highlight: Rectangle { color: "{{bg_green}}"; radius: 5; width: list.width }
              highlightMoveDuration: 0
              delegate: Item {
                height: 30
                width: list.width
                required property DesktopEntry modelData;
                property DesktopEntry application: modelData;
                Row {
                  IconImage {
                    Layout.alignment: Qt.AlignVCenter
                    asynchronous: true
                    implicitSize: 30
                    source: Quickshell.iconPath(modelData.icon)
                  }
                  Text {
                    color: "{{fg}}"
                    text: application.name
                    font.pointSize:18
                  }
                }
              }
              ScrollBar.vertical: ScrollBar { }
            }

            Connections {
                target: search
                onTextChanged: list.currentIndex = 0
            }
          }
        }
      }
    }
  }
}
