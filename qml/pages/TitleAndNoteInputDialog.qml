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
            topMargin: 40
            left: parent.left
            leftMargin: 80
        }
    }
    Column {
        anchors {
            top: dialogHeader.bottom
            topMargin: 40
        }
        spacing: 30
        TextField {
             id: titleField
             focus: true
             width: 480
             placeholderText: "Add title..."
             text: title
             onTextChanged: title = text;
        }
        TextArea {
            id: textarea
            width: 480
            color: "lightgreen"
            wrapMode: TextEdit.Wrap
            placeholderText: "Note..."
            text: note
            font.pixelSize: 22
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
