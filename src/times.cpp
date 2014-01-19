#include <QTime>
#include <QSharedPointer>
#include <QString>
#include <QDateTime>
#include "times.h"

Times::Times(QObject *parent) : QObject(parent), elapsedTime(0)
{
    _state = QSharedPointer<MeeGo::QmDisplayState>(new MeeGo::QmDisplayState);
    connect(_state.data(),
            SIGNAL(displayStateChanged(MeeGo::QmDisplayState::DisplayState)),
            this, SLOT(readTimes(MeeGo::QmDisplayState::DisplayState)));
}

void Times::readTimes(MeeGo::QmDisplayState::DisplayState state)
{
    if (state == MeeGo::QmDisplayState::DisplayState::Off) {
        elapsedTime = 0;
        timer->start();
    } else if (state == MeeGo::QmDisplayState::DisplayState::On) {
        elapsedTime = timer->elapsed();
    }
}

int Times::getElapsedTimeOnSleep() const
{
    return elapsedTime;
}

bool Times::isDeviceSleep() const {
    if (_state.data()->get() == MeeGo::QmDisplayState::DisplayState::Off) {
     return true;
    } else {
     return false;
    }
}

QString Times::startTime() const {
    return QDateTime::currentDateTime().toString("ddd MMMM dd yyyy hh:mm:ss");
}

void Times::setDisplayModeOn() const {
    _state.data()->set(MeeGo::QmDisplayState::DisplayState::On);
}

