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
    anchors.margins: 3
    Repeater {
      model: NotificationManager.list
        NotificationPanel {
          required property TrackedNotification modelData
          notification: modelData
        }
    }
  }
}
