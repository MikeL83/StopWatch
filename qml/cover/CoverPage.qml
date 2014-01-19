import QtQuick 2.0
import Sailfish.Silica 1.0
import "../pages/components"
import "../pages/scripts/HelperVariables.js" as HV

CoverBackground {

    property bool active: status === Cover.Active

    FontLoader {
        id: digitalFont
        source: "qrc:/fonts/fonts/DS-DIGII.TTF"
    }

    CoverPlaceholder {
        Label {
            id: label
            anchors {
                left: parent.left
                bottom: parent.bottom
            }

            text: "StopWatch"
            color: Theme.secondaryHighlightColor
            font.pixelSize: Theme.fontSizeLarge*1.75
            transform: Rotation {angle: -60}
        }
        opacity: 0.35
    }

    CounterView {
        id: covercounterview
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        Component.onCompleted: {
            width = rw;
        }
        transform: Translate {y: -Theme.paddingLarge}
        scale: 0.5;
    }

    CoverActionList {
        id: coverAction
        CoverAction {
            iconSource: "image://theme/icon-cover-play"
            onTriggered: {
                HV.TIMER.start();
                HV.ISTIMERRUNNING = true;
            }

        }
        CoverAction {
            iconSource: "image://theme/icon-cover-pause"
            onTriggered: {
                HV.TIMER.stop();
                HV.ISTIMERRUNNING = false;
            }
        }
    }
    onActiveChanged: {
        if (!active && HV.ISTIMERRUNNING && times.isDeviceSleep()) {
            HV.ISUPDATEAVAILABLE = false;
            HV.TIMESBEFORESLEEP = [parseInt(HV.COVERCOUNTER.htext),parseInt(HV.COVERCOUNTER.mtext),
                                   parseFloat(HV.COVERCOUNTER.stext)];
        } else if (active && times.getElapsedTimeOnSleep() > 2000 && HV.ISTIMERRUNNING) {
            if (parseInt(HV.TIMESBEFORESLEEP.reduce(function(prev,cur) {return prev + cur})) !== 0) {
                HV.ISUPDATEAVAILABLE = true;
            }
        }
    }
    Component.onCompleted: {
        HV.COVERCOUNTER = covercounterview;
    }
}




