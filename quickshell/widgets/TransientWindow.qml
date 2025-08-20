import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Hyprland

Item {
  id: root
  required property ShellScreen screen
  property string namespace
  required property string ipcTarget
  required property real widthRatio
  required property real heightRatio
  required property Component component

  property PersistentProperties persist: PersistentProperties {
      id: persist
      property bool open: false;
  }

  IpcHandler {
    target: ipcTarget
    function display(open: bool): void { persist.open = open }
    function toggle(): void { persist.open = !persist.open }
  }

  LazyLoader {
    activeAsync: persist.open
    PanelWindow {
      id: w

      screen: screen

      WlrLayershell.namespace: namespace

      exclusionMode: ExclusionMode.Ignore
      WlrLayershell.layer: WlrLayer.Overlay
      WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive


      anchors {
        top: true
        left: true
        bottom: true
        right: true
      }

      focusable: true
      color: "transparent"

      contentItem {
        focus: true
        Keys.onPressed: (event) => {
          if (event.key == Qt.Key_Escape) { persist.open = false; }
        }
      }

      Rectangle {
        anchors.fill: parent
        color: "{{tint}}"

        MouseArea {
          anchors.fill: parent
          onClicked: persist.open = false
          MouseArea {
            anchors.centerIn: parent
            width: parent.width * widthRatio
            height: parent.height * heightRatio
            Loader {
              anchors.fill: parent
              sourceComponent: component
            }
          }
        }
      }
    }
  }
}
