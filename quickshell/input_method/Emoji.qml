import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Io

Item {
    KeyboardTextEdit {
    id: input_method

    transform: function (text: string): string {
      if (input_method.contentHint & ContentHint.LATIN) {
        console.log(input_method.contentHint);
        return text;
      }
      return {
        "cool": "😎"
      }[text];
    }

    // popupSurface: Item {
    //   Text {
    //     text: "hi"
    //   }
    // }
  }
  IpcHandler {
    target: "emoji"

    function get(): void { input_method.grabKeyboard(); }

    function popup(): void {input_method.showPopup(); }
  }
}
