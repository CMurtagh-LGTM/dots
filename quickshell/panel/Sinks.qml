import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Services.Pipewire

// TODO instead of column layout have buttons to scroll between
ColumnLayout{
  Repeater {
    model: ScriptModel {
      values: Pipewire.nodes.values.filter(entry => entry.isSink && entry.audio && !entry.isStream)
    }
    Rectangle{
      required property PwNode modelData
      property PwNode sink: modelData
      color: "{{bg2}}"

      Layout.fillWidth: true
      Layout.alignment: Qt.AlignTop
      implicitHeight: 60

      radius: 5
      border {
        color: Pipewire.defaultAudioSink.id == sink.id ? "{{bg_green}}" : "{{bg_dim}}"
        width: 3
      }

      Column{
        anchors.centerIn: parent
        Text {
          color: "{{fg}}"
          text: sink.description || sink.name
        }
        Row {
          spacing: 3
          Text{
            color: "{{fg}}"
            text: (sink.audio.volume * 100).toFixed(1)
            width: 28
          }
          Slider{
            id: control
            value: sink.audio.volume
            anchors.verticalCenter: parent.verticalCenter
            onMoved: sink.audio.volume = value
            background: Rectangle {
              x: control.leftPadding
              y: control.topPadding + control.availableHeight / 2 - height / 2
              implicitWidth: 200
              implicitHeight: 4
              width: control.availableWidth
              height: implicitHeight
              radius: 2
              color: "{{bg3}}"

              Rectangle {
                width: control.visualPosition * parent.width
                height: parent.height
                color: "{{green}}"
                radius: 2
              }
            }
            handle: Rectangle {
              x: control.leftPadding + control.visualPosition * (control.availableWidth - width)
              y: control.topPadding + control.availableHeight / 2 - height / 2
              implicitWidth: 12
              implicitHeight: 12
              radius: 3
              color: control.pressed ? "{{bg3}}" : "{{bg2}}"
              border.color: "{{bg_dim}}"
            }
          }
          Rectangle {
            width: 16 
            height: 16
            color: "{{bg3}}"
            border.color: "{{bg_dim}}"
            Text {
              anchors.centerIn: parent
              id: text
              text: sink.audio.muted ? "󰝟" : "󰕾"
            }
            MouseArea {
              id: mouse
              cursorShape: Qt.PointingHandCursor
              anchors.fill: parent
              hoverEnabled: true
              onClicked: sink.audio.muted = !sink.audio.muted
            }
          }
        }
      }
      PwObjectTracker {
        objects: [sink]
      }
    }
  }
}
