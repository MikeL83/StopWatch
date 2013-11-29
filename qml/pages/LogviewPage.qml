import QtQuick 2.0
import Sailfish.Silica 1.0

//LogviewPage.qml

Page {
    id: logviewpage
    width: Screen.width
    height: Screen.height

    property var logdata: []

    SilicaFlickable {
        anchors.fill: parent
        PageHeader {
            id: pageheader
            title: logdata.title
        }
        Column {
            anchors {
                top: pageheader.bottom
                left: parent.left
                leftMargin: 20
                right: parent.right
                rightMargin: 20
                topMargin: 30
            }
            spacing: 10
            Label {
                id: numoflaps
                x: Theme.paddingSmall
                text: "Number of laps:   " + logdata.numoflaps
                font.pixelSize: 26
                color: Theme.primaryColor
                style: Text.Sunken
            }
            Label {
                id: tottime
                x: Theme.paddingSmall
                text: "Total time:   " + logdata.totaltime
                font.pixelSize: 26
                color: Theme.primaryColor
                style: Text.Sunken
            }
            Label {
                id: maxlaptime
                x: Theme.paddingSmall
                text: "Max lap time:   " + logdata.maxlap
                font.pixelSize: 26
                color: Theme.primaryColor
                style: Text.Sunken
            }
            Label {
                id: minlaptime
                x: Theme.paddingSmall
                text: "Min lap time:   " + logdata.minlap
                font.pixelSize: 26
                color: Theme.primaryColor
                style: Text.Sunken
            }
            Label {
                id: meanlaptime
                x: Theme.paddingSmall
                text: "Mean lap time:   " + logdata.meanlap
                font.pixelSize: 26
                color: Theme.primaryColor
                style: Text.Sunken
            }
            Separator {
                id: separator
                x: Theme.paddingSmall
                width: root.width
                height: 2
                color: "#66CCFF"
            }
            TextEdit {
                id: textarea
                width: separator.width
                x: Theme.paddingSmall
                color: "lightgreen"
                text: logdata.note
                wrapMode: TextEdit.WordWrap
                readOnly: true
                font.bold: false
                font.pixelSize: 22
                font.family: Theme.fontFamily
            }
        }
        states: [
            State {
                name: "show textarea"
                when: textarea.text !== ""
                PropertyChanges {
                    target: textarea; opacity: 1.0;
                }
            },
            State {
                name: "hide textarea "
                when: textarea.text === ""
                PropertyChanges {
                    target: textarea; opacity: 0.0
                }
            }
        ]
    }
}
