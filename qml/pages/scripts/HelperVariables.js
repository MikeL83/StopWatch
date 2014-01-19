.pragma library

var LAPS = 0;
var INTERVALS = 0;
var COVER_SEC = "00.0";
var COVER_MIN = "00";
var COVER_HOURS = "000";
var TIMER;
var COVERCOUNTER;
var TIMESBEFORESLEEP = [0, 0, 0.0];
var ISTIMERRUNNING = false;
var ISINTERVALTIMERRUNNING = false;
var ISINTERVALRESTTIMERRUNNING = false;
var ISUPDATEAVAILABLE = false;

function updateTimeAfterSleep(etime) {
    var toSecs = function (msec) {
        return msec * 0.001;
    }
    if (parseInt(TIMESBEFORESLEEP.reduce(function(prev,cur) {return prev + cur})) === 0) {
        return 0;
    }
    var newTime = [0,0,0.0];
    var h = parseInt(Math.floor(toSecs(etime) / 3600));
    var min = parseInt(Math.floor(toSecs(etime) / 60) - Math.floor(
        toSecs(etime) / 3600) * 60);
    var sec = toSecs(etime).toFixed(1) - (Math.floor(toSecs(etime) /
                60) -
            Math.floor(toSecs(etime) / 3600) * 60) * 60 -
        Math.floor(toSecs(etime) / 3600) * 3600;
    if (sec > 0) {
        if (TIMESBEFORESLEEP[2] + sec > 59.9) {
            newTime[2] = TIMESBEFORESLEEP[2] + sec - 60;
            newTime[1] = 1;
        } else {
            newTime[2] = TIMESBEFORESLEEP[2] + sec;
        }
        newTime[2] = newTime[2].toFixed(1);
    }
    if (min > 0) {
        if (TIMESBEFORESLEEP[1] + min + newTime[1] > 59) {
            newTime[1] += TIMESBEFORESLEEP[1] + min - 60;
            newTime[0] = 1;
        } else {
            newTime[1] += TIMESBEFORESLEEP[1] + min;
        }
    } else {
        newTime[1] += TIMESBEFORESLEEP[1];
    }

    if (h > 0) {
        if (TIMESBEFORESLEEP[0] + h + newTime[0] > 999) {
            return [0,0,0.0];
        } else {
            newTime[0] += TIMESBEFORESLEEP[0] + h;
        }
    } else {
        newTime[0] += TIMESBEFORESLEEP[0];
    }

    TIMESBEFORESLEEP = [0, 0, 0.0];
    return newTime;
}
