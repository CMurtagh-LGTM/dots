import QtQuick
import Quickshell.Services.UPower

Rectangle {
    color: "{{bg2}}"
    height: 30
    width: text.contentWidth > 0 ? text.contentWidth + 8 : 0

    Text {
        id: text
        anchors.centerIn: parent
        font.pixelSize: 16
        function getBatteryIcon(level_step: real, charging = false): string {
            if (charging) {
                if (level_step === 0) { return "󰢜"; }
                if (level_step === 10) { return "󰂆"; }
                if (level_step === 20) { return "󰂇"; }
                if (level_step === 30) { return "󰂈"; }
                if (level_step === 40) { return "󰢝"; }
                if (level_step === 50) { return "󰂉"; }
                if (level_step === 60) { return "󰢞"; }
                if (level_step === 70) { return "󰂊"; }
                if (level_step === 80) { return "󰂋"; }
                if (level_step >= 90) { return "󰂅"; }
            }

            if (level_step === 0) { return "󰁺"; }
            if (level_step === 10) { return "󰁻"; }
            if (level_step === 20) { return "󰁼"; }
            if (level_step === 30) { return "󰁽"; }
            if (level_step === 40) { return "󰁾"; }
            if (level_step === 50) { return "󰁿"; }
            if (level_step === 60) { return "󰂀"; }
            if (level_step === 70) { return "󰂁"; }
            if (level_step === 80) { return "󰂂"; }
            if (level_step >= 90) { return "󰁹"; }
            return "󰂃";
        }

        text: {
            if (!UPower.displayDevice.isLaptopBattery) {
                return "";
            }

            let level_step = Math.floor(UPower.displayDevice.percentage * 10) * 10;
            let level = Math.floor(UPower.displayDevice.percentage * 100);
            let charging = [UPowerDeviceState.Charging, UPowerDeviceState.FullyCharged, UPowerDeviceState.PendingCharge].includes(UPower.displayDevice.state);
            return getBatteryIcon(level_step, charging) + " " + level;
        }
        color: !UPower.onBattery || UPower.displayDevice.percentage > 0.2 ? "{{fg}}" : "{{red}}"
    }
}
