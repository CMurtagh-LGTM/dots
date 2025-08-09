import QtQuick
import QtQuick.Layouts
import Quickshell

Rectangle {
  required property TrackedNotification notification
  implicitHeight: 100
  anchors.right: parent.right
  anchors.left: parent.left

  color: "{{bg2}}"

  property Region region: Region {
    item: parent
  }

  Item {
    anchors.fill: parent
    RowLayout {
      anchors.right: parent.right
      anchors.left: parent.left
      anchors.top: parent.top
      anchors.bottom: border.top
      anchors.leftMargin: 5
      anchors.rightMargin: 5
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
          color: "{{fg}}"
          text: notification.summary
          font.pointSize: 12
          width: parent.width
          elide: Text.ElideRight
        }
        Text {
          id: body
          color: "{{fg}}"
          text: notification.body
          font.pointSize: 12
          width: parent.width
          elide: Text.ElideRight
        }
      }
    }
    Rectangle {
      id: border
      anchors.right: parent.right
      anchors.left: parent.left
      anchors.bottom: parent.bottom
      height: 3
      color: "{{bg_dim}}"
    }
  }
}
