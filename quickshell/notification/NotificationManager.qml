pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Services.Notifications

Singleton {
  id: root

  readonly property list<TrackedNotification> list: []
  readonly property list<TrackedNotification> popups: list.filter(n => n.popup)
  property Component notifComponent: TrackedNotification {}

  NotificationServer {
    id: server

    keepOnReload: false
    actionsSupported: true
    bodyHyperlinksSupported: true
    bodyImagesSupported: true
    bodyMarkupSupported: true
    imageSupported: true

    function dropped(notif: TrackedNotification): void {
      list.splice(list.indexOf(notif), 1);
    }

    onNotification: notif => {
      notif.tracked = true;

      root.list.push(notifComponent.createObject(root, {
        popup: true,
        notification: notif
      }));
    }
  }

  IpcHandler {
    target: "notifs"

    function clear(): void {
      for (const notif of root.list) {
        notif.popup = false;
      }
    }
  }

  Instantiator {
    model: root.notifications

    Connections {
      required property TrackedNotification modelData;
      target: modelData.notification.Retainable;

      function onDropped() {
        root.notifications = root.notifications.filter(n => n != modelData);
      }

      function onAboutToDestroy(): void {
        modelData.destroy();
      }
    }
  }
}
