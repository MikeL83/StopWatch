import QtQuick 2.0
import Sailfish.Silica 1.0

//CounterView.qml

Item {
    id: counterview
    property alias htext: hours.text
    property alias mtext: minutes.text
    property alias stext: seconds.text
    property real rw: row.width
    property real rh: row.childrenRect.height

    Row {
        id: row
        spacing: 5
        Column {
            spacing: 10
            Label {
                id: hours
                text: "000"
                font.pixelSize: 70
                font.family: digitalFont.name
            }
            Label {
                id: hourTitle
                text: qsTr("hours")
                font.pixelSize: 22
            }
        }
        Label {
            text: " : "
            font.pixelSize: 70
            font.family: digitalFont.name
        }

        Column {
            spacing: 10
            Label {
                id: minutes
                text: "00"
                font.pixelSize: 70
                font.family: digitalFont.name
            }
            Label {
                id: minuteTitle
                text: qsTr("minutes")
                font.pixelSize: 22
            }
        }
        Label {
            text: " : "
            font.pixelSize: 70
            font.family: digitalFont.name
        }
        Column {
            id: col1
            spacing: 10
            Label {
                id: seconds
                text: "00.0"
                font.pixelSize: 70
                font.family: digitalFont.name
            }
            Label {
                id: secondTitle
                text: qsTr("seconds")
                font.pixelSize: 22
            }
        }
    }
    Component.onCompleted: {
        secondTitle.x = (seconds.width - secondTitle.width)/2
        minuteTitle.x = (minutes.width - minuteTitle.width)/2
        hourTitle.x = (hours.width - hourTitle.width)/2
    }
}
