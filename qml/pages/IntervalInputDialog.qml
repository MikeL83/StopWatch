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
        clip: true
        focus: false
        anchors.fill: parent
        width: parent.width
        DialogHeader {
            id: dialogHeader
            width: parent.width
            anchors {
                topMargin: Theme.paddingLarge
                left: parent.left
            }
        }
        Column {
            id: col
            width: parent.width
            anchors {
                top: dialogHeader.bottom
                topMargin: Theme.paddingSmall
                left: parent.left
                leftMargin: Theme.paddingLarge*3
                right: parent.right
                rightMargin: Theme.paddingLarge*3
            }
            spacing: Theme.paddingSmall
            TextField {
                 id: numofintervals
                 width: parent.width
                 anchors.horizontalCenter: parent.horizontalCenter
                 placeholderText: "Number of intervals..."
                 onTextChanged: !isNaN(parseInt(text)) ? container.intervalnum = parseInt(text) : container.intervalnum = 0
                 validator: IntValidator{bottom: 0; top: 1000}
                 font.pixelSize: Theme.fontSizeMedium
                 color: Theme.secondaryHighlightColor
            }

            Separator {
                width: parent.width
                height: 3
                color: Theme.secondaryHighlightColor
            }

            Column {
                spacing: 0
                TextField {
                    id: intervaltime
                    anchors.margins: 0
                    width: dialog.width
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "Set interval time"
                    font.pixelSize: Theme.fontSizeLarge
                    color: Theme.primaryColor
                    font.family: Theme.fontFamily
                    readOnly: true
                }
                Row {
                    width: dialog.width
                    anchors.horizontalCenter: intervaltime.horizontalCenter
                    TextField {
                         id: hours
                         width: Math.floor(parent.width/4)
                         placeholderText: "hour"
                         onTextChanged: !isNaN(parseInt(text)) ? container.h = parseInt(text) : container.h = 0
                         validator: IntValidator{bottom: 0; top: 999}
                         font.pixelSize: Theme.fontSizeMedium
                         color: Theme.secondaryHighlightColor
                    }
                    TextField {
                         id: minutes
                         width: Math.floor(parent.width/4)
                         placeholderText: "min"
                         onTextChanged: !isNaN(parseInt(text)) ? container.min = parseInt(text) : container.min = 0
                         validator: IntValidator{bottom: 0; top: 59}
                         font.pixelSize: Theme.fontSizeMedium
                         color: Theme.secondaryHighlightColor
                    }
                    TextField {
                        id: seconds
                        width: Math.floor(parent.width/4)
                        placeholderText: "sec"
                        onTextChanged: !isNaN(parseInt(text)) ? container.sec = parseInt(text) : container.sec = 0
                        validator: IntValidator{bottom: 0; top: 59}
                        font.pixelSize: Theme.fontSizeMedium
                        color: Theme.secondaryHighlightColor
                    }
                }

            }

            Separator {
                width: parent.width
                height: 3
                color: Theme.secondaryHighlightColor
            }

            Column {
                spacing: 0
                TextField {
                     id: resttime
                     anchors.margins: 0
                     width: dialog.width
                     anchors.horizontalCenter: parent.horizontalCenter
                     text: "Set rest time"
                     font.pixelSize: Theme.fontSizeLarge
                     color: Theme.primaryColor
                     font.family: Theme.fontFamily
                     readOnly: true
                }
                Row {
                    width: dialog.width
                    anchors.horizontalCenter: resttime.horizontalCenter
                    TextField {
                         id: resttimehours
                         width: Math.floor(parent.width/4)
                         placeholderText: "hour"
                         onTextChanged: !isNaN(parseInt(text)) ? container.resttimeh = parseInt(text) : container.resttimeh = 0
                         validator: IntValidator{bottom: 0; top: 999}
                         font.pixelSize: Theme.fontSizeMedium
                         color: Theme.secondaryHighlightColor
                    }
                    TextField {
                         id: resttimeminutes
                         width: Math.floor(parent.width/4)
                         placeholderText: "min"
                         onTextChanged: !isNaN(parseInt(text)) ? container.resttimemin = parseInt(text) : container.resttimemin = 0
                         validator: IntValidator{bottom: 0; top: 59}
                         font.pixelSize: Theme.fontSizeMedium
                         color: Theme.secondaryHighlightColor
                    }
                    TextField {
                         id: resttimeseconds
                         width: Math.floor(parent.width/4)
                         placeholderText: "sec"
                         onTextChanged: !isNaN(parseInt(text)) ? container.resttimesec = parseInt(text) : container.resttimesec = 0
                         validator: IntValidator{bottom: 0; top: 59}
                         font.pixelSize: Theme.fontSizeMedium
                         color: Theme.secondaryHighlightColor
                    }
                }
            }
            Separator {
                width: parent.width
                height: 3
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
                 label: "Play sound"
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


