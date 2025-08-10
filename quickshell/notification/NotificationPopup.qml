import QtQuick
import QtQuick.Layouts
import Quickshell

import qs.widgets

Item {
  id: root
  required property TrackedNotification notification

  property Region region: Region {
    item: popup
  }

  property real dragDistance: 500

  width: popup.width
  height: popup.height

  Rectangle {
    id: popup
    implicitWidth: 250
    implicitHeight: 100

    property color _textColour: "{{fg}}"

    color: "{{bg2}}"
    border {
      color: "{{bg_dim}}"
      width: 3
    }
    radius: 5

    RowLayout {
      anchors.fill: parent
      anchors.margins: 5
      Image {
        visible: notification.image && notification.image != ""
        source: notification.image
        Layout.fillHeight: true
        Layout.preferredWidth: height
      }
      Column {
        Layout.fillHeight: true
        Layout.fillWidth: true
        Text {
          id: summary
          color: popup._textColour
          text: notification.summary
          font.pointSize: 12
          width: parent.width
          elide: Text.ElideRight
        }
        Text {
          id: body
          color: popup._textColour
          text: notification.body
          font.pointSize: 12
          width: parent.width
          elide: Text.ElideRight
        }
      }
    }
  }

  DragManager {
    id: dragManager
    anchors.fill: parent
    acceptedButtons: Qt.LeftButton | Qt.RightButton

    onClicked: (mouse) => {
      if (mouse.button === Qt.RightButton) {
        notification.popup = false
      }
    }

    onDragDiffXChanged: () => {
      const x = Math.max(Math.min(dragDiffX, root.dragDistance), 0);
      popup.x = x
      const alpha = 1 - x/root.dragDistance
      popup.color.a = alpha
      popup.border.color.a = alpha
      popup._textColour.a = alpha
    }

    onDragReleased: (diffX, diffY) => {
      if (diffX > 70) {
        notification.popup = false
      } else {
        dragManager.resetDrag();
      }
    }
  }
}
