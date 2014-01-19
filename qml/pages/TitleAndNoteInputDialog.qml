import QtQuick 2.0
import Sailfish.Silica 1.0
import "scripts/StopWatchDB.js" as SwDB

//TitleAndNoteInputDialog.qml

Dialog {
    id: dialog
    width: Screen.width

    property string title: ""
    property string note: ""
    property string stime

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
            topMargin: Theme.paddingLarge
            left: parent.left
            leftMargin: Theme.paddingMedium
        }
        spacing: Theme.paddingMedium
        TextField {
             id: titleField
             width: parent.width
             focus: true
             placeholderText: qsTr("Add title...")
             text: title
             onTextChanged: title = text;
             font.pixelSize: Theme.fontSizeLarge
        }
        TextArea {
            id: textarea
            width: parent.width
            color: "lightgreen"
            wrapMode: TextEdit.Wrap
            placeholderText: qsTr("Note...")
            text: note
            font.pixelSize: Theme.fontSizeMedium
            font.family: Theme.fontFamily
            onTextChanged: note = text
        }
    }
    onDone: {
         if (result === DialogResult.Accepted) {
             SwDB.updateTitleAndNote(stime,title,note);
         }
    }
}
