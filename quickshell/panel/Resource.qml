import QtQuick
import QtQuick.Layouts
import QtQuick.Shapes
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

  RowLayout {
    anchors.margins: 25
    anchors.fill: parent
    Resource {
      value: SystemUsage.cpuPerc
      colour: "{{fg}}"
      label: "CPU"
      middleLabel: `${SystemUsage.cpuTemp.toFixed(1)}℃`
    }
    Resource {
      value: SystemUsage.gpuPerc
      colour: "{{fg}}"
      label: "GPU"
      middleLabel: `${SystemUsage.gpuTemp.toFixed(1)}℃`
    }
    Resource {
      value: SystemUsage.memPerc
      colour: "{{fg}}"
      label: "MEM"
      middleLabel: `${(SystemUsage.memUsed/1048576).toFixed(1)}GB`
    }
  }

  component Resource: Item {
    id: resource
    required property real value
    required property color colour
    required property string label
    required property string middleLabel

    Layout.fillWidth: true
    implicitHeight: width

    Shape {
      anchors.fill: parent
      ShapePath{
        strokeColor: "{{bg1}}"
        strokeWidth: 5
        fillColor: "transparent"
        capStyle: ShapePath.RoundCap

        startX: 0
        startY: 0
        PathAngleArc {
          startAngle: 105
          sweepAngle: 330

          centerX: resource.width/2
          centerY: resource.height/2
          radiusX: resource.width/2 - 10
          radiusY: resource.height/2 - 10
        }
      }
      ShapePath{
        strokeColor: colour
        strokeWidth: 5
        fillColor: "transparent"
        capStyle: ShapePath.RoundCap

        startX: 0
        startY: 0
        PathAngleArc {
          startAngle: 105
          sweepAngle: value * 330

          centerX: resource.width/2
          centerY: resource.height/2
          radiusX: resource.width/2 - 10
          radiusY: resource.height/2 - 10
        }
      }
    }
    Text {
      id: label
      text: resource.label
      anchors.horizontalCenter: parent.horizontalCenter
      anchors.bottom: parent.bottom
      color: "{{fg}}"
    }
    Text {
      id: middleLabel
      text: resource.middleLabel
      anchors.centerIn: parent
      color: "{{fg}}"
    }
    Behavior on value {
        NumberAnimation { duration: 100 }
    }
  }
}
