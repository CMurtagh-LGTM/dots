import Quickshell
import Quickshell.Services.Mpris
import QtQuick

Row {
  spacing: 0
  Repeater {
    model: Mpris.players
    Rectangle {
      required property MprisPlayer modelData
      property MprisPlayer player: modelData
      width: image.width
      height: 30

      color: "{{bg2}}"

      Image {
        id: image
        source: player.trackArtUrl
        fillMode: Image.PreserveAspectCrop
        width: 280
        height: 27
        Text {
          anchors.centerIn: parent
          color: "{{fg}}"
          id: text
          font.pixelSize: 16
          width: parent.width - 8
          text: `${player.trackTitle || "Unknown"} - ${player.trackAlbum || "Unknown"}`
          elide: Text.ElideRight
        }
      }

      Rectangle {
        id: progressBar
        height: 3
        width: (player.position/player.length) * image.width
        FrameAnimation {
          running: player.playbackState == MprisPlaybackState.Playing
          onTriggered: player.positionChanged()
        }
        anchors {
          bottom: parent.bottom
          left: parent.left
        }
        color: player.isPlaying ? "{{green}}" : "{{fg}}"
      }

      MouseArea {
        cursorShape: Qt.PointingHandCursor
        anchors.fill: parent
        hoverEnabled: true
        onClicked: player.togglePlaying()
      }

      // TODO use popup
      // Tooltip {
      //   contentItem: Row {
      //     Text {
      //       text: "a"
      //     }
      //     Text {
      //       text: "b"
      //     }
      //   }
      // }
    }
  }
}
