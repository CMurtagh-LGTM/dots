import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Services.Pipewire

// TODO animate scroll

Rectangle{
  property list<PwNode> model: Pipewire.nodes.values.filter(entry => entry.isSink && entry.audio && !entry.isStream)
  property int index: model.findIndex((node) => node.id == Pipewire.defaultAudioSink.id)
  property PwNode sink: model[index]
  property bool isDefaultSink: Pipewire.defaultAudioSink.id == sink.id

  color: "{{bg2}}"

  implicitHeight: column.implicitHeight + column.anchors.margins * 2

  radius: 5
  border {
    color: isDefaultSink ? "{{bg_green}}" : "{{bg_dim}}"
    width: 3
  }

  ColumnLayout {
    id: column
    implicitHeight: selector.implicitHeight + volume.implicitHeight
    anchors.margins: 20
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: parent.top
    Item {
      id: selector
      implicitHeight: name.implicitHeight
      Layout.fillWidth: true
      Text {
        anchors.horizontalCenter: parent.horizontalCenter
        id: name
        color: "{{fg}}"
        text: sink.description || sink.name
      }
      Text{
        id: select
        color: "{{fg}}"
        text: ""
        visible: !isDefaultSink
        anchors.left: name.right
        MouseArea {
          id: mouse_select
          cursorShape: Qt.PointingHandCursor
          anchors.fill: parent
          hoverEnabled: true
          onClicked: Pipewire.preferredDefaultAudioSink = sink
        }
      }
      Text{
        id: left
        color: "{{fg}}"
        text: ""
        visible: model.length > 1
        MouseArea {
          id: mouse_left
          cursorShape: Qt.PointingHandCursor
          anchors.fill: parent
          hoverEnabled: true
          onClicked: index = (index - 1) % model.length
        }
      }
      Text{
        anchors.right: parent.right
        id: right
        color: "{{fg}}"
        text: ""
        visible: model.length > 1
        MouseArea {
          id: mouse_right
          cursorShape: Qt.PointingHandCursor
          anchors.fill: parent
          hoverEnabled: true
          onClicked: index = (index + 1) % model.length
        }
      }
    }
    Item {
      id: volume
      implicitHeight: Math.max(percent.implicitHeight, control.implicitHeight, mute.implicitHeight)
      Layout.fillWidth: true
      Text {
        id: percent
        color: "{{fg}}"
        text: (sink.audio.volume * 100).toFixed(1)
        width: 32
      }
      Slider {
        id: control
        value: sink.audio.volume
        onMoved: sink.audio.volume = value
        anchors.left: percent.right
        anchors.right: mute.left
        anchors.rightMargin: 4
        background: Rectangle {
          x: control.leftPadding
          y: control.topPadding + control.availableHeight / 2 - height / 2
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
        id: mute
        width: 16 
        height: 16
        color: mouse.containsMouse ? "{{bg4}}": "{{bg3}}"
        border.color: "{{bg_dim}}"
        anchors.right: parent.right
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
