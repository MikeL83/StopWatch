import QtQuick 2.0
import Sailfish.Silica 1.0

//TimingView.qml

Rectangle {
    id: timingview

    property alias labeltext: timinglabel.text
    property alias labelcolor: timinglabel.color
    property alias timingopacity: timingview.opacity
    property real rw: timingview.childrenRect.width
    property real rh: timingview.childrenRect.height

    width: parent.width
    opacity: 0.0

    Label {
        id: timinglabel
        font.family: Theme.fontFamily
        font.pixelSize: Theme.fontSizeExtraLarge
        style: Text.Outline
        font.bold: true
    }
    Behavior on opacity {
        NumberAnimation {
            duration: 1000
            easing.type: Easing.InOutQuad
        }
    }


}
