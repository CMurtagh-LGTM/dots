// borrowed from caelestia-dots under GPL-3.0

import Quickshell
import QtQuick

QtObject {
    required property Singleton service

    Component.onCompleted: service.refCount++
    Component.onDestruction: service.refCount--
}
