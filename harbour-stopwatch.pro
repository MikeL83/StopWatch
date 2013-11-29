# The name of your app.
# NOTICE: name defined in TARGET has a corresponding QML filename.
#         If name defined in TARGET is changed, following needs to be
#         done to match new name:
#         - corresponding QML filename must be changed
#         - desktop icon filename must be changed
#         - desktop filename must be changed
#         - icon definition filename in desktop file must be changed
TARGET = harbour-stopwatch

#CONFIG += sailfishapp

QT += quick qml

CONFIG += link_pkgconfig
PKGCONFIG += sailfishapp
INCLUDEPATH += /usr/include/sailfishapp

TARGETPATH = /usr/bin
target.path = $$TARGETPATH

DEPLOYMENT_PATH = /usr/share/$$TARGET
qml.files = qml
qml.path = $$DEPLOYMENT_PATH

desktop.files = harbour-stopwatch.desktop
desktop.path = /usr/share/applications

icon.files = $${TARGET}.png
icon.path = /usr/share/icons/hicolor/86x86/apps/

INSTALLS += target icon desktop qml

SOURCES += src/harbour-stopwatch.cpp

OTHER_FILES += qml/harbour-stopwatch.qml \
    qml/cover/CoverPage.qml \
    rpm/harbour-stopwatch.spec \
    rpm/harbour-stopwatch.yaml \
    harbour-stopwatch.desktop \
    qml/pages/TitleAndNoteInputDialog.qml \
    qml/pages/LogviewPage.qml \
    qml/pages/LogbookPage.qml \
    qml/pages/LapsPage.qml \
    qml/pages/IntervalTimerPage.qml \
    qml/pages/IntervalInputDialog.qml \
    qml/pages/FrontPage.qml \
    qml/pages/components/TimingView.qml \
    qml/pages/components/ResttimeView.qml \
    qml/pages/components/LapListDelegate.qml \
    qml/pages/components/CounterView.qml \
    qml/pages/scripts/StopWatchDB.js \
    qml/pages/scripts/StopWatch.js

RESOURCES += \
    harbour-stopwatch-resources.qrc
