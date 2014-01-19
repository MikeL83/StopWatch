import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0 as Sql
import "components"
import "scripts/StopWatch.js" as Stopwatch
import "scripts/StopWatchDB.js" as SwDB
import "scripts/HelperVariables.js" as HV

//FrontPage.qml

Page {
    id: frontpage
    width: Screen.width
    height: Screen.height

    property int msec: 0
    property int sec: 0
    property int min: 0
    property int h: 0
    property int lapnum: 0
    property string starttime: ""

    SilicaFlickable {
        anchors.fill: parent
        
        Timer {
            id: timer
            interval: 100
            running: false
            repeat: true
            onTriggered: {
                Stopwatch.startCounter();
                HV.COVERCOUNTER.htext = counterview.htext;
                HV.COVERCOUNTER.mtext = counterview.mtext;
                HV.COVERCOUNTER.stext = counterview.stext;
            }
        }

        Timer {
            id: laptimer
            interval: 3000
            running: false
            repeat: false
            onTriggered: {
                timingview.opacity = 0.0
            }
        }

        FontLoader {
            id: digitalFont
            source: "qrc:/fonts/fonts/DS-DIGII.TTF"
        }

        PullDownMenu {
            MenuItem {
                text: qsTr("About")
                onClicked: pageStack.push(Qt.resolvedUrl("AboutPage.qml"));
            }
            MenuItem {
                text: qsTr("Laps")
                onClicked: {
                    Stopwatch.updateLaps();
                    pageStack.push(Qt.resolvedUrl("LapsPage.qml"),{"laps": Stopwatch.LAPS});
                }
            }
            MenuItem {
                text: qsTr("Logbook")
                onClicked: pageStack.push(Qt.resolvedUrl("LogbookPage.qml"));
            }
            MenuItem {
                text: qsTr("Interval timer")
                onClicked: pageStack.push(Qt.resolvedUrl("IntervalTimerPage.qml"));
            }
        }
        PageHeader {
            id: pageHeader
            title: "Stopwatch"
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
            text: qsTr("Elapsed Time")
            font.pixelSize: Theme.fontSizeLarge
            font.family: Theme.fontFamily

        }
        CounterView {
            id: counterview
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
            text: qsTr("Lap") + "   " + lapnum
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
                    state: "released"
                    scale: 1.1
                    hoverEnabled: true

                    onClicked: {
                        timer.stop();
                        Stopwatch.ISTIMERRUNNING = false;
                        SwDB.saveLap(starttime,Stopwatch.totalTime(),Stopwatch.minlap(),Stopwatch.maxlap(),
                                     Stopwatch.meanlap(),Stopwatch.LAPS.length,"","");
                        lapnum = 0;
                        Stopwatch.resetTime();
                        Stopwatch.LAPS = [];
                        lapbutton.enabled = false;
                        HV.COVERCOUNTER.htext = counterview.htext;
                        HV.COVERCOUNTER.mtext = counterview.mtext;
                        HV.COVERCOUNTER.stext = counterview.stext;
                        HV.ISTIMERRUNNING = false;
                        HV.TIMESBEFORESLEEP = [0,0,0.0];
                    }
                    onPressed: resetbutton.state = "pressed";
                    onReleased: resetbutton.state = "released";

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
                    font.family: Theme.fontFamily
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
                        timer.running == false ? timer.start() : timer.stop();
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
                                    if (timer.running) {
                                        if (lapnum === 0) {
                                            lapnum = 1;
                                            lapbutton.enabled = true;
                                            starttime = times.startTime();
                                        }
                                        if (Stopwatch.LAPS.length > 0) {
                                            Stopwatch.updateLaps();
                                        } else {
                                            Stopwatch.LAPS.push("Lap " + lapnum + ": " + counterview.htext + " : " + counterview.mtext
                                                            + " : " + counterview.stext);
                                        }
                                        HV.LAPS = lapnum;
                                        HV.ISTIMERRUNNING = timer.running;
                                    }
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
                                    if (!timer.running) {
                                        if (lapnum > 0) {
                                            if (Stopwatch.LAPS.length > 0) {
                                                Stopwatch.updateLaps();
                                            } else {
                                                Stopwatch.LAPS.push("Lap " + lapnum + ": " + counterview.htext + " : " + counterview.mtext
                                                                + " : " + counterview.stext);
                                            }
                                        }
                                        HV.LAPS = lapnum;
                                        HV.ISTIMERRUNNING = timer.running;
                                    }
                                }
                            }
                        }
                    ]
                    transitions: [
                        Transition {
                            from: "stop time"
                            to: "start time"
                            NumberAnimation { target: startbutton; property: "opacity"
                                              from: 0.25; to: 1.0; duration: 250;
                                              easing.type: Easing.InOutQuad }
                    },
                        Transition {
                            from: "start time"
                            to: "stop time"
                            NumberAnimation { target: startbutton; property: "opacity"
                                              from: 0.25; to: 1.0; duration: 250;
                                              easing.type: Easing.InOutQuad}
                        }
                    ]

                }
                Label {
                    id: startlabel
                    text: qsTr("Start")
                    font.pixelSize: 26
                    font.family: Theme.fontFamily
                    anchors.horizontalCenter: startbutton.horizontalCenter
                    transform: Translate{y:-10}
                }
            }
            Column {
                spacing: 0
                IconButton {
                    id: lapbutton
                    icon.source: "qrc:/images/images/lapsbutton.png"
                    scale: 1.1
                    enabled: false
                    state: "released"
                    onClicked: {
                        Stopwatch.updateLaps();
                        Stopwatch.CURRENTLAP = [parseInt(counterview.htext),parseInt(counterview.mtext),parseFloat(counterview.stext)];
                        lapnum += 1;
                        if (lapnum > 2) {
                            timingview.opacity = 1.0
                            var values = Stopwatch.calculateDifferenceBetweenLaps();
                            if (values[3]) {
                                timingview.labeltext = "- " + Stopwatch.displayTimeforHours(values[0]) + " : "
                                                      + Stopwatch.displayTime(values[1]) + " : " + Stopwatch.displayTimeforSecs((values[2]));
                                timingview.labelcolor = "red"
                            } else {
                                timingview.labeltext = "+ " + Stopwatch.displayTimeforHours(values[0]) + " : "
                                                      + Stopwatch.displayTime(values[1]) + " : " + Stopwatch.displayTimeforSecs(values[2]);
                                timingview.labelcolor = "green"
                            }
                            laptimer.running = true;
                            Stopwatch.LAPS.push("Lap " + lapnum + ": " + "000" + " : " + "00"
                                           + " : " + "00.0");
                        } else {
                            Stopwatch.LAPS.push("Lap " + lapnum + ": " + "000" + " : " + "00"
                                           + " : " + "00.0");
                        }
                        HV.LAPS = lapnum;
                    }

                    onPressed: lapbutton.state = "pressed"
                    onReleased: lapbutton.state = "released"

                    states: [
                        State {
                        name: "pressed"
                        PropertyChanges {
                            target: lapbutton; icon.source: "qrc:/images/images/lapsbutton.png"
                        }
                    },
                    State {
                        name: "released"
                        PropertyChanges {
                            target: lapbutton; icon.source: "qrc:/images/images/lapsbutton.png"
                        }
                    }
                    ]
                    transitions: [
                        Transition {
                            from: "pressed"
                            to: "released"
                            NumberAnimation { target: lapbutton; property: "opacity"
                                              from: 0.25; to: 1.0; duration: 500;
                                              easing.type: Easing.InOutQuad}
                        },
                        Transition {
                            from: "released"
                            to: "pressed"
                            NumberAnimation { target: lapbutton; property: "opacity"
                                              from: 0.25; to: 1.0; duration: 500;
                                              easing.type: Easing.InOutQuad}
                        }
                    ]
                }
                Label {
                    text: qsTr("Lap")
                    font.pixelSize: 26
                    font.family: Theme.fontFamily
                    anchors.horizontalCenter: lapbutton.horizontalCenter
                    transform: Translate{y:-10}
                }
            }
        }

        TimingView {
            id: timingview
            anchors {
                top: timingrow.bottom
                topMargin: 30 + timingview.rh
                left: parent.left
                leftMargin: (frontpage.width - timingview.rw)/2
            }
        }
    }
    Component.onCompleted: {
        HV.TIMER = timer;
        counterview.anchors.leftMargin = (frontpage.width - counterview.rw)/2;
        laps.anchors.leftMargin = (frontpage.width - counterview.rw)/2;
    }


}


