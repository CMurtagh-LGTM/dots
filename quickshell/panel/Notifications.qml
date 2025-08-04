import QtQuick
import QtQuick.Layouts
import Quickshell

import qs.notification

Rectangle { 
  color: "{{bg2}}"
  radius: 5
  border {
    color: "{{bg_dim}}"
    width: 3
  }

  Column {
    anchors.fill: parent
    Repeater {
      model: NotificationManager.list
      Rectangle {
        required property TrackedNotification modelData
        property TrackedNotification notification: modelData
        width: parent.width
        height: 100
        color: "{{bg2}}"

        Column {
          anchors.fill: parent
          Text {
            color: "{{fg}}"
            text: notification.summary
          }
          Text {
            color: "{{fg}}"
            text: notification.body
          }
          Rectangle {
            anchors.bottom: parent.bottom
            height: 1
            width: parent.width
            color: "{{bg_dim}}"
          }
        }
      }
    }
  }
}
