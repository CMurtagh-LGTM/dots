import QtQuick
import QtQuick.Controls
import Quickshell

import qs.notification

Rectangle { 
  color: "{{bg2}}"
  radius: 5
  border {
    color: "{{bg_dim}}"
    width: 3
  }

  Flickable{
    anchors.fill: parent
    anchors.margins: 3
    contentWidth: width
    contentHeight: column.height
    boundsBehavior: Flickable.StopAtBounds
    Column {
      id: column
      anchors.top: parent.top
      anchors.left: parent.left
      anchors.right: parent.right
      Repeater {
        model: NotificationManager.list
          NotificationPanel {
            required property TrackedNotification modelData
            notification: modelData
          }
      }
    }
    ScrollBar.vertical: ScrollBar { }
  }
}
