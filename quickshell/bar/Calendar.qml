import QtQuick
import QtQuick.Controls

// borrowed from caelestia-dots under GPL-3.0

Rectangle {
  color: "{{bg2}}"
  radius: 5
  border {
    color: "{{bg_dim}}"
    width: 3
  }

  width: 320
  height: column.height

  Column {
    id: column

    anchors.left: parent.left
    anchors.right: parent.right
    padding: 10
    spacing: 10

    DayOfWeekRow {
      id: days

      locale: Qt.locale("en_US")

      anchors.left: parent.left
      anchors.right: parent.right
      anchors.margins: parent.padding

      delegate: Text {
        required property var model

        horizontalAlignment: Text.AlignHCenter
        text: model.shortName
        color: "{{fg}}"
      }
    }

    Rectangle {
      anchors.left: parent.left
      anchors.right: parent.right
      anchors.leftMargin: parent.padding
      anchors.rightMargin: parent.padding
      height: 1
      color: "{{bg_dim}}"
    }

    MonthGrid {
      id: grid

      locale: Qt.locale("en_US")

      anchors.left: parent.left
      anchors.right: parent.right
      anchors.margins: parent.padding

      spacing: 3

      delegate: Item {
        id: day

        required property var model

        implicitWidth: implicitHeight
        implicitHeight: text.implicitHeight + 10 * 2

        Rectangle {
          anchors.centerIn: parent

          implicitWidth: parent.implicitHeight
          implicitHeight: parent.implicitHeight

          radius: 5
          color: day.model.today ? "{{bg_green}}" : "transparent"

          Text {
              id: text

              anchors.centerIn: parent

              horizontalAlignment: Text.AlignHCenter
              text: Qt.formatDate(day.model.date, "d")
              color:  grid.month === model.month ? "{{fg}}" : "transparent"
          }
        }
      }
    }
  }
}
