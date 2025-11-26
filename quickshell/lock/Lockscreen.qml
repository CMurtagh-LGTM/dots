import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland

Item {
	LockContext {
		id: lockContext

		onUnlocked: {
			// Unlock the screen before exiting, or the compositor will display a
			// fallback lock you can't interact with.
			lock.locked = false;

			Qt.quit();
		}
	}

	WlSessionLock {
		id: lock

		// Lock the session immediately when quickshell starts.
		locked: false

		WlSessionLockSurface {
			LockSurface {
				anchors.fill: parent
				context: lockContext
			}
		}
  }

	IpcHandler {
		target: "lock"
		function lock(): void { lock.locked = true; }
		function unlock(): void { lock.locked = false; }
	}
}
