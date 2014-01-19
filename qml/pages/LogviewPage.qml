import QtQuick 2.0
import Sailfish.Silica 1.0

//LogviewPage.qml

Page {
    id: logviewpage
    width: Screen.width
    height: Screen.height

    property var logdata: []

    SilicaFlickable {
        id: view
        clip: true
        focus: false
        anchors.fill: parent
        PageHeader {
            id: pageheader
            title: logdata.title
        }
        Column {
            id: col
            width: parent.width
            anchors {
                top: pageheader.bottom
                left: parent.left
                leftMargin: Theme.paddingLarge
                right: parent.right
                rightMargin: Theme.paddingLarge
                topMargin: Theme.paddingLarge
            }
            spacing: 10
            Row {
                id: numoflapsrow
                spacing: Theme.paddingSmall
                Label {
                    text: "Number of laps:"
                    font.pixelSize: Theme.fontSizeMedium
                    color: Theme.primaryColor
                }
                Label {
                    id: numoflaps
                    text: logdata.numoflaps
                    font.pixelSize: Theme.fontSizeMedium
                    color: "#0066CC"
                    font.bold: true
                }
            }
            Row {
                id: totaltimerow
                spacing: Theme.paddingSmall
                Label {
                    text: "Total time:"
                    font.pixelSize: Theme.fontSizeMedium
                    color: Theme.primaryColor
                }
                Label {
                    text: logdata.totaltime
                    font.pixelSize: Theme.fontSizeMedium
                    color: "#0066CC"
                    font.bold: true
                }
            }
            Row {
                id: maxlaprow
                spacing: Theme.paddingSmall
                Label {
                    text: "Max lap time:"
                    font.pixelSize: Theme.fontSizeMedium
                    color: Theme.primaryColor
                }
                Label {
                    text: logdata.maxlap
                    font.pixelSize: Theme.fontSizeMedium
                    color: "#0066CC"
                    font.bold: true
                }
            }
            Row {
                id: minlaprow
                spacing: Theme.paddingSmall
                Label {
                    text: "Min lap time:"
                    font.pixelSize: Theme.fontSizeMedium
                    color: Theme.primaryColor
                }
                Label {
                    text: logdata.minlap
                    font.pixelSize: Theme.fontSizeMedium
                    color: "#0066CC"
                    font.bold: true
                }

            }
            Row {
                id: meanlaprow
                spacing: Theme.paddingSmall
                Label {
                    text: "Mean lap time:"
                    font.pixelSize: Theme.fontSizeMedium
                    color: Theme.primaryColor
                }
                Label {
                    text: logdata.meanlap
                    font.pixelSize: Theme.fontSizeMedium
                    color: "#0066CC"
                    font.bold: true
                }
            }
            Separator {
                id: separator
                width: col.width
                height: 2
                color: Theme.primaryColor
            }
            TextEdit {
                id: textarea
                color: "lightgreen"
                text: logdata.note
                wrapMode: TextEdit.WordWrap
                readOnly: true
                font.bold: false
                font.pixelSize: Theme.fontSizeMedium
                font.family: Theme.fontFamily
            }
        }
        states: [
            State {
                name: "show textarea"
                when: textarea.text !== ""
                PropertyChanges {
                    target: textarea; visible: true
                }
            },
            State {
                name: "hide textarea "
                when: textarea.text === ""
                PropertyChanges {
                    target: textarea; visible: false
                }
            }
        ]
    }
}
