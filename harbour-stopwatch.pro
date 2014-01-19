# The name of your app.
# NOTICE: name defined in TARGET has a corresponding QML filename.
#         If name defined in TARGET is changed, following needs to be
#         done to match new name:
#         - corresponding QML filename must be changed
#         - desktop icon filename must be changed
#         - desktop filename must be changed
#         - icon definition filename in desktop file must be changed
TARGET = harbour-stopwatch

CONFIG += sailfishapp

LIBS += -lqmsystem2-qt5
DEPENDPATH += /usr/include/qmsystem2-qt5
INCLUDEPATH += /usr/include/qmsystem2-qt5

QMAKE_CXXFLAGS += -std=c++0x

SOURCES += src/harbour-stopwatch.cpp \
    src/times.cpp

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
    qml/pages/scripts/StopWatch.js \
    qml/pages/scripts/HelperVariables.js \
    qml/pages/AboutPage.qml

RESOURCES += \
    harbour-stopwatch-resources.qrc

HEADERS += \
    src/times.h
