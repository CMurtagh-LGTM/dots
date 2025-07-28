import QtQuick

Rectangle {
  id: root
  required property string text

  signal clicked
  Component.onCompleted: {
    mouse.clicked.connect(clicked)
  }

  implicitHeight: 24
  implicitWidth: 24
  radius: 12
  color: mouse.containsMouse ? "{{bg3}}" : "{{bg2}}"
  Text {
    anchors.centerIn: parent
    color: "{{fg}}"
    text: root.text 
    MouseArea {
      id: mouse
      cursorShape: Qt.PointingHandCursor
      anchors.fill: parent
      hoverEnabled: true
    }
  }
}
