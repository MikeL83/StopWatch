import QtQuick 2.0
import Sailfish.Silica 1.0

//IntervalInputDialog.qml

Dialog {
    id: dialog
    width: Screen.width
    height: Screen.height

    property var container: null

    SilicaFlickable {
        id: view
        anchors.fill: parent

        DialogHeader {
            id: dialogHeader
            width: parent.width
            anchors {
                topMargin: 20
                left: parent.left
                leftMargin: 80
            }
        }
        Column {
            anchors {
                top: dialogHeader.bottom
                topMargin: 10
                horizontalCenter: parent.horizontalCenter
            }
            spacing: 0
            TextField {
                 id: numofintervals
                 width: dialog.width/1.5
                 placeholderText: "Number of intervals..."
                 onTextChanged: !isNaN(parseInt(text)) ? container.intervalnum = parseInt(text) : container.intervalnum = 0
                 validator: IntValidator{bottom: 0; top: 1000}
                 font.pixelSize: Theme.fontSizeSmall
                 color: "steelblue"
            }

            Separator {
                anchors.margins: 0
                width: parent.width
                height: 2
                color: Theme.secondaryHighlightColor
            }

            Column {
                spacing: 0
                anchors.horizontalCenter: parent.horizontalCenter
                TextField {
                     anchors.margins: 0
                     width: dialog.width/1.5
                     text: "Set interval time"
                     font.pixelSize: Theme.fontSizeMedium
                     color: Theme.primaryColor
                     font.family: Theme.fontFamily
                     readOnly: true
                }
                TextField {
                     id: hours
                     anchors.margins: 0
                     width: dialog.width/1.5
                     placeholderText: "hours"
                     onTextChanged: !isNaN(parseInt(text)) ? container.h = parseInt(text) : container.h = 0
                     validator: IntValidator{bottom: 0; top: 999}
                     font.pixelSize: Theme.fontSizeSmall
                     color: "steelblue"
                }
                TextField {
                     id: minutes
                     anchors.margins: 0
                     width: dialog.width/1.5
                     placeholderText: "minutes"
                     onTextChanged: !isNaN(parseInt(text)) ? container.min = parseInt(text) : container.min = 0
                     validator: IntValidator{bottom: 0; top: 59}
                     font.pixelSize: Theme.fontSizeSmall
                     color: "steelblue"
                }
                TextField {
                     id: seconds
                     anchors.margins: 0
                     width: dialog.width/1.5
                     placeholderText: "seconds"
                     onTextChanged: !isNaN(parseInt(text)) ? container.sec = parseInt(text) : container.sec = 0
                     validator: IntValidator{bottom: 0; top: 59}
                     font.pixelSize: Theme.fontSizeSmall
                     color: "steelblue"
                }

            }

            Separator {
                anchors.margins: 0
                width: parent.width
                height: 2
                color: Theme.secondaryHighlightColor
            }

            Column {
                spacing: 0
                anchors.horizontalCenter: parent.horizontalCenter
                TextField {
                     anchors.margins: 0
                     width: parent.width/1.5
                     text: "Set rest time"
                     font.pixelSize: Theme.fontSizeMedium
                     color: Theme.primaryColor
                     font.family: Theme.fontFamily
                     readOnly: true
                }
                TextField {
                     id: resttimehours
                     width: dialog.width/1.5
                     placeholderText: "hours"
                     onTextChanged: !isNaN(parseInt(text)) ? container.resttimeh = parseInt(text) : container.resttimeh = 0
                     validator: IntValidator{bottom: 0; top: 999}
                     font.pixelSize: Theme.fontSizeSmall
                     color: "steelblue"
                }
                TextField {
                     id: resttimeminutes
                     width: dialog.width/1.5
                     placeholderText: "minutes"
                     onTextChanged: !isNaN(parseInt(text)) ? container.resttimemin = parseInt(text) : container.resttimemin = 0
                     validator: IntValidator{bottom: 0; top: 59}
                     font.pixelSize: Theme.fontSizeSmall
                     color: "steelblue"
                }
                TextField {
                     id: resttimeseconds
                     width: dialog.width/1.5
                     placeholderText: "seconds"
                     onTextChanged: !isNaN(parseInt(text)) ? container.resttimesec = parseInt(text) : container.resttimesec = 0
                     validator: IntValidator{bottom: 0; top: 59}
                     font.pixelSize: Theme.fontSizeSmall
                     color: "steelblue"
                }
            }
            Separator {
                anchors.margins: 0
                width: parent.width
                height: 2
                color: Theme.secondaryHighlightColor
            }
            Slider {
                 id: sounds
                 anchors.horizontalCenter: parent.horizontalCenter
                 width: dialog.width/2
                 minimumValue: 0
                 maximumValue: 1
                 value: 0
                 stepSize: 1
                 valueText: value ? "|" : "O"
                 label: "Enable sound"
            }

        }

        contentHeight: childrenRect.height

        VerticalScrollDecorator {
            flickable: view
        }
    }
    onDone: {
         if (result === DialogResult.Accepted) {
            !isNaN(parseInt(numofintervals.text)) ? container.intervalnum = parseInt(numofintervals.text) : container.intervalnum = 0
            !isNaN(parseInt(hours.text)) ? container.h = parseInt(hours.text) : container.h = 0
            !isNaN(parseInt(minutes.text)) ? container.min = parseInt(minutes.text) : container.min = 0
            !isNaN(parseInt(seconds.text)) ? container.sec = parseInt(seconds.text) : container.sec = 0
            !isNaN(parseInt(resttimehours.text)) ? container.resttimeh = parseInt(resttimehours.text) : container.resttimeh = 0
            !isNaN(parseInt(resttimeminutes.text)) ? container.resttimemin = parseInt(resttimeminutes.text) : container.resttimemin = 0
            !isNaN(parseInt(resttimeseconds.text)) ? container.resttimesec = parseInt(resttimeseconds.text) : container.resttimesec = 0
            container.sec_t = container.sec
            container.min_t = container.min
            container.h_t = container.h
            container.resttimesec_t = container.resttimesec
            container.resttimemin_t = container.resttimemin
            container.resttimeh_t = container.resttimeh
            container.soundenabled = sounds.value
         }
    }
}


