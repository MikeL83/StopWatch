#ifndef TIMES_H
#define TIMES_H

#include <QObject>
#include <qmsystem2-qt5/qmdisplaystate.h>
#include <QSharedPointer>

class QTime;
class QString;

class Times : public QObject
{
    Q_OBJECT
  public:
    explicit Times(QObject *parent = 0);
    Q_INVOKABLE int getElapsedTimeOnSleep() const;
    Q_INVOKABLE bool isDeviceSleep() const;
    Q_INVOKABLE QString startTime() const;
    Q_INVOKABLE void setDisplayModeOn() const;

  public slots:
    void readTimes(MeeGo::QmDisplayState::DisplayState state);

  signals:
    void displayStateChanged(MeeGo::QmDisplayState::DisplayState state);

  private:
    QSharedPointer<MeeGo::QmDisplayState> _state;
    QTime *timer;
    int elapsedTime;
};

#endif // TIMES_H
