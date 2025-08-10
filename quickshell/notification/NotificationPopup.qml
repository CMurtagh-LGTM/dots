import QtQuick
import QtQuick.Layouts
import Quickshell

import qs.widgets

Flickable {
  id: root
  required property TrackedNotification notification

  property Region region: Region {
    item: popup
  }

  property real dragDistance: 100

  width: 250
  height: 100
  opacity: 1.0 - Math.max(-horizontalOvershoot, 0) / dragDistance
  onHorizontalOvershootChanged: notification.popup = Math.max(-horizontalOvershoot, 0) < dragDistance

  contentWidth: 250
  contentHeight: 100
  rightMargin: 1

  Rectangle {
    id: popup
    anchors.fill: parent

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
  
  MouseArea {
    anchors.fill: parent
    acceptedButtons: Qt.RightButton
    onClicked: notification.popup = false
  }
}
