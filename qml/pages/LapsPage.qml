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
            title: "Lap timings"
        }
        spacing: Theme.paddingMedium
        delegate: BackgroundItem {
            Column {
                anchors {
                    left: parent.left
                    leftMargin: 20
                }
                spacing: 5
                Label {
                    id: label
                    x: Theme.paddingLarge
                    text: laps[index]
                }
                Rectangle {
                    height: 1
                    width: label.width
                    x: Theme.paddingLarge
                    color: "steelblue"
                }
            }
        }

        ViewPlaceholder {
            enabled: laps.length === 0
            text: "No current laps"
        }
    }
}





