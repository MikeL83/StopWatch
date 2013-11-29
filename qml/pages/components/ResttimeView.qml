import QtQuick 2.0
import Sailfish.Silica 1.0

//ResttimeView.qml

Item {
    id: resttimeview
    property alias htext: hours.text
    property alias mtext: minutes.text
    property alias stext: seconds.text
    property real rw: row.childrenRect.width
    property real rh: row.childrenRect.height

    Row {
        id: row
        spacing: 5
        Label {
            id: hours
            text: "000"
            font.pixelSize: 50
            font.family: digitalFont.name
            color: "green"
        }
        Label {
            text: "  :  "
            font.pixelSize: 50
            font.family: digitalFont.name
            color: "green"
        }
        Label {
            id: minutes
            text: "00"
            font.pixelSize: 50
            font.family: digitalFont.name
            color: "green"
        }
        Label {
            text: "  :  "
            font.pixelSize: 50
            font.family: digitalFont.name
            color: "green"
        }
        Label {
            id: seconds
            text: "00"
            font.pixelSize: 50
            font.family: digitalFont.name
            color: "green"
        }
    }
    transitions: Transition {
            from: "*"
            to: "*"
            NumberAnimation { property: "visible"
                              duration: 500; easing.type: Easing.InOutQuad }
            }


}
