import QtQuick 2.0
import Sailfish.Silica 1.0
import QtMultimedia 5.0
import "components"
import "scripts/StopWatch.js" as Stopwatch
import "scripts/HelperVariables.js" as HV

//IntervalTimerPage.qml

Page {
    id: intervalpage

    width: Screen.width
    height: Screen.height

    property int sec: 0
    property int min: 0
    property int h: 0
    property int sec_t: 0
    property int min_t: 0
    property int h_t: 0
    property int resttimesec: 0
    property int resttimemin: 0
    property int resttimeh: 0
    property int resttimesec_t: 0
    property int resttimemin_t: 0
    property int resttimeh_t: 0
    property int intervalnum: 0
    property string starttime: ""
    property int soundenabled: 1

    SilicaFlickable {
        anchors.fill: parent

        Timer {
            id: timer
            interval: 1000
            running: false
            repeat: true
            onTriggered: {
                Stopwatch.startCounterforInterval();
            }
        }

        Timer {
            id: timerForResttime
            interval: 1000
            running: false
            repeat: true
            onTriggered: {
                Stopwatch.startCounterforResttime();
            }
        }

        FontLoader {
            id: digitalFont
            source: "qrc:/fonts/fonts/DS-DIGII.TTF"
        }

        SoundEffect {
            id: playSound
            source: "qrc:/sounds/sounds/beep-4.wav"
            loops: 3
        }

        PullDownMenu {
            MenuItem {
                text: qsTr("Set interval")
                onClicked: pageStack.push(Qt.resolvedUrl("IntervalInputDialog.qml"),{"container": intervalpage})
            }

        }
        PageHeader {
            id: pageHeader
            title: qsTr("Stopwatch")
            anchors.horizontalCenter: parent.horizontalCenter
        }

        contentHeight: childrenRect.height

        Label {
            id: title
            anchors {
                top: pageHeader.bottom
                topMargin: 40
                left: counterview.left
            }
            transform: Translate{x: -Theme.paddingLarge}
            text: qsTr("Time")
            color: Theme.primaryColor
            font.pixelSize: Theme.fontSizeLarge
            font.family: Theme.fontFamily
        }

        CounterView {
            id: counterview
            width: width
            stext: "00"
            anchors {
                top: title.bottom
                topMargin: Theme.paddingLarge*2
                horizontalCenter: timingrow.horizontalCenter
            }
            Component.onCompleted: {
                width = rw;
            }
        }

        Label {
            id: laps
            anchors {
                top: counterview.bottom
                horizontalCenter: parent.horizontalCenter
            }
            text: qsTr("Interval") + "   " + intervalnum
            font.pixelSize: 45
            color: Theme.primaryColor

            Component.onCompleted: {
                anchors.topMargin = counterview.rh + Theme.paddingLarge
            }
        }

        Row {
            id: timingrow
            spacing: Theme.paddingLarge*2
            anchors {
                top: laps.bottom
                topMargin: Theme.paddingLarge
                horizontalCenter: parent.horizontalCenter
            }
            Column {
                spacing: 0
                IconButton {
                    id: resetbutton
                    icon.source: "qrc:/images/images/resetbutton.png"
                    scale: 1.1
                    state: "released"
                    hoverEnabled: true
                    onClicked: {
                        timer.stop();
                        timerForResttime.stop()
                        intervalnum = 0
                        if (resttimeview.visible) resttimeview.visible = false
                        Stopwatch.resetTimeforInterval();
                    }
                    onPressed: resetbutton.state = "pressed"
                    onReleased: resetbutton.state = "released"

                    states: [
                        State {
                        name: "pressed"
                        PropertyChanges {
                            target: resetbutton; icon.source: "qrc:/images/images/resetbutton.png"
                        }
                    },
                    State {
                        name: "released"
                        PropertyChanges {
                            target: resetbutton; icon.source: "qrc:/images/images/resetbutton.png"
                        }
                    }
                    ]
                    transitions: [
                        Transition {
                            from: "pressed"
                            to: "released"
                            NumberAnimation { target: resetbutton; property: "opacity"
                                              from: 0.25; to: 1.0; duration: 500;
                                              easing.type: Easing.InOutQuad}
                        },
                        Transition {
                            from: "released"
                            to: "pressed"
                            NumberAnimation { target: resetbutton; property: "opacity"
                                              from: 0.25; to: 1.0; duration: 500;
                                              easing.type: Easing.InOutQuad}
                        }
                    ]
                }
                Label {
                    text: qsTr("Reset")
                    font.pixelSize: 26
                    anchors.horizontalCenter: resetbutton.horizontalCenter
                    transform: Translate{y:-10}
                }
            }
            Column {
                spacing: 0
                IconButton {
                    id: startbutton
                    icon.source: "qrc:/images/images/playbutton.png"
                    scale: 1.1
                    onPressed: {
                        if (Stopwatch.checkEndingforInterval() || timerForResttime.running) {
                            return;
                        } else {
                            if (!timer.running) {
                                timer.start()
                            } else {
                                timer.stop()
                            }
                        }
                    }

                    states: [
                        State {
                            name: "start time"
                            when: timer.running
                            PropertyChanges {
                                target: startbutton; icon.source: "qrc:/images/images/stopbutton.png"
                            }
                            PropertyChanges {
                                target: startlabel; text: qsTr("Stop")
                            }
                            StateChangeScript {
                                script: {
                                    HV.ISINTERVALTIMERRUNNING = timer.running;
                                }
                            }
                        },
                        State {
                            name: "stop time"
                            when: !timer.running
                            PropertyChanges {
                                target: startbutton; icon.source: "qrc:/images/images/playbutton.png"
                            }
                            PropertyChanges {
                                target: startlabel; text: qsTr("Start")
                            }
                            StateChangeScript {
                                script: {
                                    HV.ISINTERVALTIMERRUNNING = timer.running;
                                }
                            }
                        }
                    ]
                    transitions: [
                        Transition {
                            from: "stop time"
                            to: "start time"
                            NumberAnimation { target: startbutton; property: "opacity"
                                              from: 0.25; to: 1.0; duration: 500;
                                              easing.type: Easing.InOutQuad }
                    },
                        Transition {
                            from: "start time"
                            to: "stop time"
                            NumberAnimation { target: startbutton; property: "opacity"
                                              from: 0.25; to: 1.0; duration: 500;
                                              easing.type: Easing.InOutQuad}
                        }
                    ]

                }
                Label {
                    id: startlabel
                    text: qsTr("Start")
                    font.pixelSize: 26
                    anchors.horizontalCenter: startbutton.horizontalCenter
                    transform: Translate{y:-10}
                }
            }
        }

        Label {
            id: resttimeTitle
            anchors {
                top: timingrow.bottom
                topMargin: Theme.paddingLarge*2
                horizontalCenter: parent.horizontalCenter
            }
            text: qsTr("Rest time")
            font.family: Theme.fontFamily
            font.pixelSize: Theme.fontSizeLarge
            color: Theme.primaryColor

            visible: resttimeview.visible
        }

        ResttimeView {
            id: resttimeview
            anchors {
                top: resttimeTitle.bottom
                topMargin: Theme.paddingLarge
                horizontalCenter: parent.horizontalCenter
            }
            visible: false

            Component.onCompleted: {
                width = rw;
            }
        }

        states: [
            State {
                name: "resttimerrunning"
                when: timerForResttime.running
                StateChangeScript {
                    script: {
                        HV.ISINTERVALRESTTIMERRUNNING = true;
                    }
                }
            },
            State {
                name: "resttimernotrunning"
                when: !timerForResttime.running
                StateChangeScript {
                    script: {
                        HV.ISINTERVALRESTTIMERRUNNING = false;
                    }
                }

            }
        ]

    }
    onStatusChanged: {
        if (status === PageStatus.Activating) {
            counterview.htext = Stopwatch.displayTimeforHours(h)
            counterview.mtext = Stopwatch.displayTime(min)
            counterview.stext = Stopwatch.displayTimeforSecs(sec)
            resttimeview.htext = Stopwatch.displayTimeforHours(resttimeh)
            resttimeview.mtext = Stopwatch.displayTime(resttimemin)
            resttimeview.stext = Stopwatch.displayTimeforSecs(resttimesec)
        } else if (status === PageStatus.Deactivating) {
            HV.ISINTERVALTIMERRUNNING = false;
            HV.ISINTERVALRESTTIMERRUNNING = false;
        }
    }
}


