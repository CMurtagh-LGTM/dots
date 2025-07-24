import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Widgets
import QtQuick
import QtQuick.Controls

// TODO
// Tooltip
// Icon
// Menu

Row {
  spacing: 0
  Repeater {
    model: SystemTray.items
    Rectangle {
      id: sni
      required property SystemTrayItem modelData
      property SystemTrayItem item: modelData
      color: "{{bg2}}"
      height: 30
      width: 28

      IconImage{
        source: item.icon
      }

      MouseArea {
        cursorShape: Qt.PointingHandCursor
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton

        onClicked: event => {
          if (event.button == Qt.LeftButton) {
            item.activate();
          } else if (event.button == Qt.MiddleButton) {
            item.secondaryActivate();
          } else if (event.button == Qt.RightButton) {
            menuAnchor.open();
          }
        }
        onWheel: event => {
          event.accepted = true;
          const points = event.angleDelta.y / 120
          item.scroll(points, false);
        }
      }
    }
  }
}
