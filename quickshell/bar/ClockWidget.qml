import QtQuick
import Quickshell

import qs.services

Rectangle {
    id: root
    color: "{{bg2}}"
    height: 30
    width: text.contentWidth + 8
    Text {
        id: text
        text: Time.time
        color: "{{fg}}"
        anchors.centerIn: parent
        font.pixelSize: 16
    }
    PopupWindow {
        id: calendar
        color: "transparent"
        anchor.item: root
        anchor.edges: Edges.Bottom
        anchor.margins.left: -width
        anchor.margins.bottom: -10
        implicitWidth: calendarComponent.width
        implicitHeight: calendarComponent.height
        Calendar {
            id: calendarComponent
        }
    }
    MouseArea {
        id: mouse
        cursorShape: Qt.PointingHandCursor
        anchors.fill: parent
        hoverEnabled: true
        onClicked: calendar.visible = !calendar.visible
    }
}
