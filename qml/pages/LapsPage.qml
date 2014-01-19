import QtQuick 2.0
import Sailfish.Silica 1.0

//LapsPage.qml

Page {
    id: page
    width: Screen.width
    height: Screen.height

    property var laps: []

    SilicaListView {
        id: lapsView
        clip: true
        focus: false
        model: laps.length
        anchors.fill: parent
        header: PageHeader {
            title: qsTr("Lap timings")
        }
        spacing: Theme.paddingMedium
        delegate: BackgroundItem {
            width: parent.width
            height: col.childrenRect.height
            Column {
                id: col
                anchors {
                    margins: 0
                    horizontalCenter: parent.horizontalCenter
                }
                spacing: 10
                Label {
                    id: label
                    //x: Theme.paddingLarge
                    text: laps[index]
                    font.pixelSize: Theme.fontSizeLarge
                    font.bold: true
                    color: "#0066CC"
                }
                Separator {
                    id: separator
                    width: label.width
                    height: 3
                    color: Theme.primaryColor
                }
            }
        }
        ViewPlaceholder {
            enabled: laps.length === 0
            text: qsTr("No current laps")
        }
    }
}





