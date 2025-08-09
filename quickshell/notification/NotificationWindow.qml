import QtQuick
import Quickshell
import Quickshell.Hyprland 
import Quickshell.Wayland

Scope {
  property list<TrackedNotification> notifications: NotificationManager.popups
  Variants {
    model: Quickshell.screens // TODO only current screen

    PanelWindow {
      property var modelData
      screen: modelData
	  WlrLayershell.namespace: "shell:notifications"

      exclusionMode: ExclusionMode.Ignore
      anchors {
        top: true
        left: true
        bottom: true
        right: true
      }
      mask: Region {
        item: notificationsColumn
      }
      margins {
        left: 30
        top: 60
      }
      visible: notifications.length != 0

      color: "transparent"

      Column {
        id: notificationsColumn
        spacing: 3

        Repeater {
          model: notifications 
          NotificationPopup {
            required property TrackedNotification modelData
            notification: modelData
          }
        }
      }
    }
  }
}
