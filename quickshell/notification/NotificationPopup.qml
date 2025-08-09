import QtQuick
import QtQuick.Layouts
import Quickshell

Rectangle {
  required property TrackedNotification notification
  implicitWidth: 250
  implicitHeight: 100

  color: "{{bg2}}"
  border {
    color: "{{bg_dim}}"
    width: 3
  }
  radius: 5

  property Region region: Region {
    item: parent
  }

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
  MouseArea {
    anchors.fill: parent
    onClicked: notification.popup = false
  }
}
