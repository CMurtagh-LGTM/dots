import QtQuick
import QtQuick.Layouts
import QtQuick.Shapes
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Mpris

import qs.services
import qs.widgets

Rectangle {
  property int spotifyIndex: Mpris.players.values.findIndex((p) => p.identity == "Spotify")
  property int index: spotifyIndex != -1 ? spotifyIndex : 0
  property MprisPlayer player: Mpris.players.values[index]
  property int playerCount: Mpris.players.values.length

  color: "{{bg2}}"
  radius: 5
  border {
    color: "{{bg_dim}}"
    width: 3
  }

  ColumnLayout {
    anchors.fill: parent
    anchors.margins: 20
    Item {
      id: albumArt
      Layout.fillHeight: true
      Layout.minimumWidth: height
      Layout.maximumWidth: parent.width
      Layout.maximumHeight: parent.width
      Layout.alignment: Qt.AlignHCenter
      ClippingRectangle {
        anchors.fill: parent
        radius: width/2
        Image {
          anchors.fill: parent
          source: player.trackArtUrl // TODO cache the image
        }
      }
      Shape {
        anchors.fill: parent
        ShapePath {
          strokeColor: "{{bg1}}"
          strokeWidth: 3
          fillColor: "transparent"

          startX : 0
          startY : 0
          PathAngleArc {
            startAngle: 0
            sweepAngle: 360

            centerX: albumArt.width/2
            centerY: albumArt.height/2
            radiusX: albumArt.width/2
            radiusY: albumArt.width/2
          }
        }
        ShapePath {
          strokeColor: player.isPlaying ? "{{green}}" : "{{fg}}"
          capStyle: ShapePath.RoundCap
          strokeWidth: 3
          fillColor: "transparent"

          startX : 0
          startY : 0
          PathAngleArc {
            startAngle: 90
            sweepAngle: (player.position/player.length) * 360

            centerX: albumArt.width/2
            centerY: albumArt.height/2
            radiusX: albumArt.width/2
            radiusY: albumArt.width/2
          }
        }
      }
    }
    ColumnLayout {
      Layout.fillHeight: true
      // Layout.fillWidth: true
      width: parent.width
      RowLayout {
        Layout.alignment: Qt.AlignHCenter
        RoundButton {
          text: ""
          visible: playerCount > 1
          onClicked: index = (((index - 1) % playerCount) + playerCount ) % playerCount
        }
        Text {
          color: "{{fg}}"
          text: `${player.identity || "Unknown"}`
        }
        RoundButton {
          text: ""
          visible: playerCount > 1
          onClicked: index = (index + 1) % playerCount
        }
      }
      Row {
        Layout.maximumWidth: parent.width
        Layout.alignment: Qt.AlignHCenter
        Text {
          color: "{{fg}}"
          text: `${player.trackTitle || "Unknown"}`
        }
        Text {
          color: "{{fg}}"
          text: player.trackAlbum ? " - " : ""
        }
        Text {
          color: "{{fg}}"
          text: `${player.trackAlbum}`
        }
      }
      Text {
        Layout.alignment: Qt.AlignHCenter
        color: "{{fg}}"
        text: `${player.trackArtist || "Unknown"}`
      }
      RowLayout {
        Layout.alignment: Qt.AlignHCenter
        RoundButton {
          text: "󰒮"
          visible: player.canGoPrevious
          onClicked: player.previous()
        }
        RoundButton {
          text: player.isPlaying ? "󰏤" : "󰐊"
          visible: player.canPlay && player.canPause
          onClicked: player.togglePlaying()
        }
        RoundButton {
          text: "󰒭"
          visible: player.canGoNext
          onClicked: player.next()
        }
      }
    }
    RowLayout {
      Layout.fillWidth: true
      Layout.fillHeight: true
      Layout.minimumHeight: parent.height / 4
      Ref {
        service: Cava
      }
      Repeater {
        model: Cava.values
        Rectangle {
          required property int modelData
          property int value: modelData
          color: "{{bg3}}"
          radius: 5
          height: 2 + value / 100 * (parent.height - 2)
          Layout.fillWidth: true
          Layout.alignment: Qt.AlignBottom
        }
      }
    }
  }
}
