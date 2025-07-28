pragma Singleton

// borrowed from caelestia-dots under GPL-3.0

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    property int visualiserBars: 11
    property list<int> values: Array(visualiserBars)
    property int refCount

    Process {
        id: cavaProc

        running: true
        command: ["sh", "-c", `printf '[general]\nframerate=60\nbars=${visualiserBars}\nsleep_timer=3\n[output]\nchannels=mono\nmethod=raw\nraw_target=/dev/stdout\ndata_format=ascii\nascii_max_range=100' | cava -p /dev/stdin`]
        stdout: SplitParser {
            onRead: data => {
                if (root.refCount)
                    root.values = data.slice(0, -1).split(";").map(v => parseInt(v, 10));
            }
        }
    }
}
