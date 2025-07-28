import QtQuick
import QtQuick.Layouts
import Quickshell

import qs.widgets
import qs.services

Rectangle{
  color: "{{bg2}}"
  radius: 5
  border {
    color: "{{bg_dim}}"
    width: 3
  }

  Ref {
    service: SystemUsage
  }

  ColumnLayout {
    anchors.margins: 25
    anchors.fill: parent
    Resource {
      value: SystemUsage.cpuPerc
      colour: "{{red}}"
      label: ""
    }
    Resource {
      value: SystemUsage.memPerc
      colour: "{{red}}"
      label: ""
    }
    Text{
      text: SystemUsage.cpuTemp
      Layout.fillWidth: true
    }
  }

  component Resource: Item {
    id: resource
    required property real value
    required property color colour
    required property string label

    implicitHeight: label.implicitHeight
    Layout.fillWidth: true

    Text {
      id: label
      text: resource.label
      anchors.verticalCenter: parent.verticalCenter
    }
    Rectangle {
      anchors.verticalCenter: parent.verticalCenter
      anchors.left: label.right
      anchors.right: parent.right
      anchors.leftMargin: 3
      implicitHeight: 4
      radius: 2
      color: "{{bg3}}"
      Rectangle {
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        implicitWidth: parent.width * value
        color: colour
        radius: 2
      }
    }
    Behavior on value {
        NumberAnimation { duration: 100 }
    }
  }
}
