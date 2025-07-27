import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets

Rectangle{
  color: "{{bg2}}"
  radius: 5
  border {
    color: "{{bg_dim}}"
    width: 3
  }

  ColumnLayout {
    anchors.fill: parent
    anchors.margins: 20
    ClippingRectangle {
      Layout.fillHeight: true
      Layout.minimumWidth: height
      Layout.alignment: Qt.AlignHCenter
      radius: width/2
      Image {
        anchors.fill: parent
        source: "pfp.png"
      }
    }
    Text {
      color: "{{fg}}"
      text: "{{username}}"
      Layout.alignment: Qt.AlignHCenter
    }
  }
}
