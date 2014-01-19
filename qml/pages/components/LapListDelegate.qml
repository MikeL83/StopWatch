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
        height: col.childrenRect.height
        Column {
            id: col
            spacing: 10
            anchors {
                left: parent.left
                right: parent.right
                leftMargin: Theme.paddingLarge
                rightMargin: Theme.paddingLarge
            }
            Column {
                id: titlecolumns
                spacing: 5
                Label {
                    id: title
                    text: titleName
                    font.pixelSize: Theme.fontSizeMedium
                }
                Label {
                    id: date
                    text: dateStr
                    font.pixelSize: Math.floor(Theme.fontSizeSmall/1.1)
                    color: "#0066CC"
                    font.bold: true
                }
            }
            Separator {
                anchors.margins: 0
                width: parent.width
                height: 2
                color: Theme.primaryColor
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
