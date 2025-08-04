import QtQuick
import Quickshell
import Quickshell.Services.Notifications

QtObject {
  id: root

  property bool popup
  readonly property date time: new Date()

  required property Notification notification
  readonly property string summary: notification.summary
  readonly property string body: notification.body
  readonly property string appIcon: notification.appIcon
  readonly property string appName: notification.appName
  readonly property string image: notification.image
  readonly property int urgency: notification.urgency
  readonly property list<NotificationAction> actions: notification.actions

  readonly property Timer timer: Timer {
    running: true
    interval: root.notification.expireTimeout > 0 ? root.notification.expireTimeout : 1000 
    onTriggered: root.popup = false;
  }
}
