import QtQuick 2.0
import Sailfish.Silica 1.0
import "components"
import "scripts/StopWatchDB.js" as SwDB

//LogbookPage.qml

Page {
    id: page
    width: Screen.width
    height: Screen.height

    property var log: []
    property Item contextMenu: null
    property int currentIndex

    SilicaListView {
        id: logbookView
        model: ListModel{id: listModel}
        clip: true
        focus: false
        anchors.fill: parent
        header: PageHeader {
            id: pageheader
            title: qsTr("Logbook details")
        }
        spacing: Theme.paddingMedium
        PullDownMenu {
            MenuItem {
                text: qsTr("Delete all records")
                onClicked: {
                    SwDB.deleteAll();
                    listModel.clear();
                    viewPlaceHolder.enabled = true;
                }
            }
        }
        ViewPlaceholder {
            id: viewPlaceHolder
            enabled: listModel.count === 0
            text: qsTr("Logbook empty")
        }
        delegate: LapListDelegate {index_: index}

        Component {
            id: contextMenuComponent
            ContextMenu {
                MenuItem {
                    text: qsTr("Add info")
                    onClicked: {
                        pageStack.push(Qt.resolvedUrl("TitleAndNoteInputDialog.qml"),{"stime": log[currentIndex].starttime,
                                        "note": log[currentIndex].note,"title": log[currentIndex].title})
                    }
                }
                MenuItem {
                    text: qsTr("Delete record")
                    onClicked: {
                        SwDB.deleteRecord(log[currentIndex].starttime);
                        listModel.remove(currentIndex)
                    }
                }
            }
        }
    }
    onStatusChanged: {
        if (status === PageStatus.Activating) {
            if (listModel.count !== 0) listModel.clear();
            log = SwDB.readLogbook();
            for (var i = 0; i < log.length; i++) {
                if (log[i].title === "") {
                    listModel.append({"titleName": "Untitled", "dateStr": log[i].starttime.substring(0,log[i].starttime.lastIndexOf(":"))});
                } else {
                    listModel.append({"titleName": log[i].title, "dateStr": log[i].starttime.substring(0,log[i].starttime.lastIndexOf(":"))});
                }
            }
            viewPlaceHolder.enabled = listModel.count === 0;
        }
    }
}
