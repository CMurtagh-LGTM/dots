pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: root

    readonly property string location: "{{weather_location}}"
    property alias icon: persist.icon
    property alias description: persist.description
    property alias temp: persist.temp
    property alias uv: persist.uv

    property PersistentProperties persist: PersistentProperties {
        id: persist
        reloadableId: "WeatherService"
        property string icon: ""
        property string description: "unloaded"
        property string temp: "-"
        property int uv: 0
    }

    function reload(): void {
        Requests.get(`https://wttr.in/${location}?format=%C,%t,%u`).then(text => {
            const details = text.split(",");
            description = details[0];
            temp = details[1].startsWith("+") ? details[1].slice(1) : details[1];
            uv = details[2];
            icon = getWeatherIcon(details[0]);
        })
    }

    Component.onCompleted: _ => {
        timer.start();
        reload();
    }

    Timer {
        id: timer
        interval: 1200000 // 20 mins
        repeat: true
    }

    function uvColour(): color {
        if (uv < 3) {
            return "{{green}}";
        } else if (uv < 6) {
            return "{{yellow}}";
        } else if (uv < 8) {
            return "{{orange}}";
        } else if (uv < 11) {
            return "{{red}}";
        } else {
            return "{{purple}}";
        }
    }

    function getWeatherIcon(desc: string): string {
        desc = desc.toLowerCase();
        if (desc == "day cloudy gusts") { return ''; }
        if (desc == "day cloudy windy") { return ''; }
        if (desc == "day cloudy") { return ''; }
        if (desc == "day fog") { return ''; }
        if (desc == "day hail") { return ''; }
        if (desc == "day lightning") { return ''; }
        if (desc == "day rain mix") { return ''; }
        if (desc == "day rain wind") { return ''; }
        if (desc == "day rain") { return ''; }
        if (desc == "day showers") { return ''; }
        if (desc == "day snow") { return ''; }
        if (desc == "day sprinkle") { return ''; }
        if (desc == "day sunny overcast") { return ''; }
        if (desc == "day sunny") { return ''; }
        if (desc == "day storm showers") { return ''; }
        if (desc == "day thunderstorm") { return ''; }
        if (desc == "cloudy gusts") { return ''; }
        if (desc == "cloudy windy") { return ''; }
        if (desc == "cloudy") { return ''; }
        if (desc == "fog") { return ''; }
        if (desc == "hail") { return ''; }
        if (desc == "lightning") { return ''; }
        if (desc == "rain mix") { return ''; }
        if (desc == "rain wind") { return ''; }
        if (desc == "rain") { return ''; }
        if (desc == "showers") { return ''; }
        if (desc == "light rain shower") { return ''; }
        if (desc == "light drizzle") { return ''; }
        if (desc == "snow") { return ''; }
        if (desc == "sprinkle") { return ''; }
        if (desc == "storm showers") { return ''; }
        if (desc == "thunderstorm") { return ''; }
        if (desc == "windy") { return ''; }
        if (desc == "night alt cloudy gusts") { return ''; }
        if (desc == "night alt cloudy windy") { return ''; }
        if (desc == "night alt hail") { return ''; }
        if (desc == "night alt lightning") { return ''; }
        if (desc == "night alt rain mix") { return ''; }
        if (desc == "night alt rain wind") { return ''; }
        if (desc == "night alt rain") { return ''; }
        if (desc == "night alt showers") { return ''; }
        if (desc == "night alt snow") { return ''; }
        if (desc == "night alt sprinkle") { return ''; }
        if (desc == "night alt storm showers") { return ''; }
        if (desc == "night alt thunderstorm") { return ''; }
        if (desc == "night clear") { return ''; }
        if (desc == "night cloudy gusts") { return ''; }
        if (desc == "night cloudy windy") { return ''; }
        if (desc == "night cloudy") { return ''; }
        if (desc == "night hail") { return ''; }
        if (desc == "night lightning") { return ''; }
        if (desc == "night rain mix") { return ''; }
        if (desc == "night rain wind") { return ''; }
        if (desc == "night rain") { return ''; }
        if (desc == "night showers") { return ''; }
        if (desc == "night snow") { return ''; }
        if (desc == "night sprinkle") { return ''; }
        if (desc == "night storm showers") { return ''; }
        if (desc == "night thunderstorm") { return ''; }
        if (desc == "cloud") { return ''; }
        if (desc == "horizon alt") { return ''; }
        if (desc == "horizon") { return ''; }
        if (desc == "night fog") { return ''; }
        if (desc == "raindrops") { return ''; }
        if (desc == "strong wind") { return ''; }
        if (desc == "sunrise") { return ''; }
        if (desc == "sunset") { return ''; }
        if (desc == "tornado") { return ''; }
        if (desc == "smoke") { return ''; }
        if (desc == "dust") { return ''; }
        if (desc == "snow wind") { return ''; }
        if (desc == "day snow wind") { return ''; }
        if (desc == "night snow wind") { return ''; }
        if (desc == "night alt snow wind") { return ''; }
        if (desc == "day sleet storm") { return ''; }
        if (desc == "night sleet storm") { return ''; }
        if (desc == "night alt sleet storm") { return ''; }
        if (desc == "day snow thunderstorm") { return ''; }
        if (desc == "night snow thunderstorm") { return ''; }
        if (desc == "night alt snow thunderstorm") { return ''; }
        if (desc == "hot") { return ''; }
        if (desc == "hurricane") { return ''; }
        if (desc == "smog") { return ''; }
        if (desc == "snowflake cold") { return ''; }
        if (desc == "day cloudy high") { return ''; }
        if (desc == "night alt cloudy high") { return ''; }
        if (desc == "night cloudy high") { return ''; }
        if (desc == "night alt partly cloudy") { return ''; }
        if (desc == "sandstorm") { return ''; }
        if (desc == "night partly cloudy") { return ''; }
        if (desc == "day windy") { return ''; }
        if (desc == "night alt cloudy") { return ''; }
        if (desc == "day sleet") { return ''; }
        if (desc == "night sleet") { return ''; }
        if (desc == "night alt sleet") { return ''; }
        if (desc == "sleet") { return ''; }
        if (desc == "day haze") { return ''; }
        if (desc == "day light wind") { return ''; }
        return '';
    }
}
