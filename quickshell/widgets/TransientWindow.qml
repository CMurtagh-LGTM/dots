import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland

PanelWindow {
  id: w

  required property ShellScreen screen
  screen: screen

  property string namespace
  WlrLayershell.namespace: namespace

  required property string ipcTarget
  required property real widthRatio
  required property real heightRatio
  required property Component component

  anchors {
    top: true
    left: true
    bottom: true
    right: true
  }

  visible: false
  focusable: true
  color: "transparent"

  IpcHandler {
    target: ipcTarget
    function display(visible: bool): void { w.visible = visible }
    function toggle(): void { w.visible = !w.visible }
  }

  contentItem {
    focus: true
    Keys.onPressed: (event) => {
      if (event.key == Qt.Key_Escape) { w.visible = false; }
    }
  }

  Rectangle {
    anchors.fill: parent
    color: "{{tint}}"

    Loader {
      anchors.centerIn: parent
      width: parent.width * widthRatio
      height: parent.height * heightRatio
      sourceComponent: component
    }
    MouseArea {
      anchors.fill: parent
      onClicked: w.visible = false
    }
  }
}
