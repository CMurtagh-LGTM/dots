import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Io

Item {
  QSInputMethod {
    id: input_method

    KeyboardTextEdit {
      transform: function (text: string): string {
        return {
            "cool": "😎"
        }[text];
      }
    }
  }
  IpcHandler {
    target: "emoji"

    function get(): void { input_method.grabKeyboard(); }
  }
}
