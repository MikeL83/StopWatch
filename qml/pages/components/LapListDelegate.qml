import QtQuick 2.0
import Sailfish.Silica 1.0

//LapListDelegate.qml

Item {
    id: root
    property bool menuOpen: contextMenu != null && contextMenu.parent === root
    property int index_

    width: logbookView.width
    height: menuOpen ? contextMenu.height + recordItem.height : recordItem.height
    BackgroundItem {
        id: recordItem
        width: parent.width
        Column {
            spacing: 10
            x: Theme.paddingLarge
            Column {
                id: titlecolumns
                spacing: 5
                Label {
                    id: title
                    text: titleName
                    font.pixelSize: 24
                    style: Text.Raised
                }
                Label {
                    id: date
                    text: dateStr
                    font.pixelSize: 20
                    color: Theme.secondaryColor
                    style: Text.Raised
                }
            }
            Separator {
                anchors.margins: 0
                width: root.width
                height: 2
                color: "#0099FF"
            }
        }
        onPressAndHold: {
            currentIndex = index_
            if (!contextMenu) {
                contextMenu = contextMenuComponent.createObject(logbookView);
            }
            contextMenu.show(root);
        }
        onClicked: {
            currentIndex = index_
            pageStack.push(Qt.resolvedUrl("../LogviewPage.qml"),{"logdata": log[index_]});
        }

    }
}
