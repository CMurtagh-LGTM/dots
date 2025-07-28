import QtQuick

import qs.services

Rectangle {
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
}
