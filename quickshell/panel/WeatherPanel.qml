import QtQuick
import Quickshell

import qs.services

Rectangle{
  color: "{{bg2}}"
  radius: 5
  border {
    color: "{{bg_dim}}"
    width: 3
  }

  Row {
    anchors.centerIn: parent
    spacing: 10
    Text {
      anchors.verticalCenter: parent.verticalCenter
      text: Weather.icon
      font.pointSize: 81
      color: "{{fg}}"
    }
    Column {
      anchors.verticalCenter: parent.verticalCenter
      Text {
        text: Weather.temp
        color: "{{fg}}"
      }
      Text {
        text: `UV: ${Weather.uv}`
        color: Weather.uvColour()
      }
      Text {
        text: Weather.description
        color: "{{fg}}"
      }
      Text {
        text: Weather.location
        color: "{{fg}}"
      }
    }
  }
}
