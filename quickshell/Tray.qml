import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Widgets
import QtQuick
import QtQuick.Controls

// TODO
// Icon

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
        id: mouse
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
            menuAnchor.menu = item.menu
            menuAnchor.open();
          }
        }
        onWheel: event => {
          event.accepted = true;
          const points = event.angleDelta.y / 120
          item.scroll(points, false);
        }
      }

      PopupWindow {
        visible: mouse.containsMouse
        implicitWidth: text.contentWidth
        implicitHeight: text.contentHeight
        color: "{{bg2}}"
        Text {
          id: text
          color: "{{fg}}"
          text: item.tooltipTitle || item.title
        }
        anchor {
          item: parent
          edges: Edges.Bottom | Edges.Left
        }
      }

      QsMenuAnchor {
        id: menuAnchor
        anchor {
          item: parent
          edges: Edges.Bottom | Edges.Left
        }
      }
    }
  }
}
