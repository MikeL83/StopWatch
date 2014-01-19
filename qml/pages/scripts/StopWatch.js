//StopWatch.js

//.pragma library
.import "HelperVariables.js" as HV
//global variables

var LAPS = [];
var CURRENTLAP = [0, 0, 0.0];

/*
moved to C++ side
function setStartTime() {
    var today = new Date();
    var h = today.getHours();
    var m = today.getMinutes();
    var s = today.getSeconds();
    if (m < 10)
        m = "0" + m;
    return today.toLocaleDateString() + " " + h + ":" + m + ":" + s;
}
*/

function displayTimeforHours(x) {
    if (x.toString().length < 2) {
        return "00" + x.toString();
    } else if (x.toString().length < 3) {
        return "0" + x.toString();
    } else {
        return x.toString();
    }
}

function displayTimeforSecs(x) {
    if (x < 10.0) {
        return "0" + x.toString();
    } else {
        return x.toString();
    }
}

function displayTime(x) {
    if (x.toString().length < 2) {
        return "0" + x.toString();
    } else {
        return x.toString();
    }
}

function resetTime() {
    msec = 0;
    sec = 0;
    min = 0;
    h = 0;
    counterview.stext = "00.0";
    counterview.mtext = "00";
    counterview.htext = "000";
}

function resetTimeforInterval() {
    sec = 0;
    min = 0;
    h = 0;
    resttimesec = 0;
    resttimemin = 0;
    resttimeh = 0;
    counterview.stext = "00";
    counterview.mtext = "00";
    counterview.htext = "000";

}

function startCounter() {
    if (HV.ISUPDATEAVAILABLE) {
        var newvalues = HV.updateTimeAfterSleep(times.getElapsedTimeOnSleep());
        if (Array.isArray(newvalues) && parseInt(newvalues.reduce(function(prev,cur) {return prev + cur})) !== 0) {
            msec = Number(String(newvalues[2]).substr(-1))
            counterview.stext = displayTimeforSecs(newvalues[2]);
            counterview.mtext = displayTime(newvalues[1]);
            counterview.htext = displayTimeforHours(newvalues[0]);
            sec = parseInt(newvalues[2]);
            min = newvalues[1];
            h = newvalues[0];
            HV.ISUPDATEAVAILABLE = false;
        }
    }
    msec += 1;
    if (msec > 9) {
        msec = 0;
        counterview.stext = counterview.stext.slice(0, counterview.stext.length -
            1) + "0";
        sec += 1;
        counterview.stext = counterview.stext.replace(/^\d{2}/, displayTime(sec));
        if (sec > 59) {
            sec = 0;
            counterview.stext = "00.0";
            min += 1;
            counterview.mtext = displayTime(min);
            if (min > 59) {
                min = 0;
                counterview.mtext = "00";
                h += 1;
                counterview.htext = displayTimeforHours(h);
                if (h > 999) {
                    resetTime();
                }
            }
        }
    } else {
        counterview.stext = counterview.stext.slice(0, counterview.stext.length -
            1) + msec.toString();
    }
}

function startCounterforInterval() {
    sec_t -= 1;
    if (sec_t < 0) {
        sec_t = 0;
        if (checkEndingforInterval()) return;
        sec_t = 59;
        counterview.stext = counterview.stext.replace(/^\d{2}/, displayTime(
            sec_t));
        if (min_t === 0 && h_t > 0) {
            min_t = 59;
            h_t -= 1;
        } else {
            min_t -= 1;
        }
        counterview.mtext = displayTime(min_t);
        counterview.htext = displayTimeforHours(h_t);
    } else {
        counterview.stext = counterview.stext.replace(/^\d{2}/, displayTime(
            sec_t));
    }
}

function startCounterforResttime() {
    resttimesec_t -= 1;
    if (resttimesec_t < 0) {
        resttimesec_t = 0;
        if (checkEndingforResttime()) return;
        resttimesec_t = 59;
        resttimeview.stext = resttimeview.stext.replace(/^\d{2}/, displayTime(
            resttimesec_t));
        if (resttimemin_t === 0 && resttimeh_t > 0) {
            resttimemin_t = 59;
            resttimeh_t -= 1;
        } else {
            resttimemin_t -= 1;
        }
        resttimeview.mtext = displayTime(resttimemin_t);
        resttimeview.htext = displayTimeforHours(resttimeh_t);
    } else {
        resttimeview.stext = resttimeview.stext.replace(/^\d{2}/, displayTime(
            resttimesec_t));
    }
}

function checkEndingforInterval() {
    if (h_t === 0 && min_t === 0 && sec_t === 0) {
        counterview.stext = counterview.stext.replace(/^\d{2}/, displayTime(
            sec_t));
        timer.stop();
        if (intervalnum > 0) {
            sec_t = sec;
            min_t = min;
            h_t = h;
            resttimesec_t = resttimesec;
            resttimemin_t = resttimemin;
            resttimeh_t = resttimeh;
            if (resttimeh > 0 || resttimemin > 0 || resttimesec > 0) {
                if (soundenabled) playSound.play();
                resttimeview.stext = resttimeview.stext.replace(/^\d{2}/,
                    displayTime(resttimesec_t));
                resttimeview.mtext = displayTime(resttimemin_t);
                resttimeview.htext = displayTimeforHours(resttimeh_t);
                resttimeview.visible = true;
                timerForResttime.start();
            }
        }
        return true;
    } else {
        return false;
    }
}

function checkEndingforResttime() {
    if (resttimeh_t === 0 && resttimemin_t === 0 && resttimesec_t === 0) {
        resttimeview.stext = resttimeview.stext.replace(/^\d{2}/, displayTime(
            resttimesec_t));
        resttimesec_t = resttimesec;
        resttimemin_t = resttimemin;
        resttimeh_t = resttimeh;
        timerForResttime.stop();
        resttimeview.visible = false;
        if (intervalnum > 0) {
            intervalnum -= 1;
            counterview.stext = counterview.stext.replace(/^\d{2}/, displayTime(
                sec_t));
            counterview.mtext = displayTime(min_t);
            counterview.htext = displayTimeforHours(h_t);
            timer.start();
        }
        return true;
    } else {
        return false;
    }
}

function updateLaps() {
    var values = calculateDifference();
    if (values !== null) {
        LAPS[LAPS.length - 1] = "Lap " + lapnum + ": " + displayTimeforHours(
            values[0]) + " : " + displayTime(values[1]) +
            " : " + displayTimeforSecs(values[2]);
    } else {
        LAPS[LAPS.length - 1] = "Lap " + lapnum + ": " + counterview.htext +
            " : " + counterview.mtext +
            " : " + counterview.stext;
    }
}

function calculateDifference() {
    if (LAPS.length > 1) {
        var diff = (parseInt(counterview.htext) * 3600 +
            parseInt(counterview.mtext) * 60 + parseFloat(counterview.stext)) -
            (CURRENTLAP[0] * 3600 + CURRENTLAP[1] * 60 + CURRENTLAP[2]);
        diff = Math.abs(diff);
        var h = parseInt(Math.floor(diff / 3600));
        var m = parseInt(Math.floor(diff / 60) - Math.floor(diff / 3600) * 60)
        var s = diff.toFixed(1) - (Math.floor(diff / 60) -
            Math.floor(diff / 3600) * 60) * 60 -
            Math.floor(diff / 3600) * 3600;
        s = s.toFixed(1);
        return [h, m, s];
    } else {
        return null;
    }
}

function calculateDifferenceBetweenLaps() {
    if (LAPS.length > 1) {
        var isNeg = false;
        var lap1 = LAPS[LAPS.length - 1];
        var lap2 = LAPS[LAPS.length - 2];
        var s = parseFloat(lap1.match(/\s(\d{2}\.\d)$/g)) - parseFloat(lap2.match(
            /\s(\d{2}\.\d)$/g));
        if (isNaN(s)) s = 0.0;

        var m = parseInt(lap1.match(/\s(\d{2})\s/g)) - parseInt(lap2.match(
            /\s(\d{2})\s/g));
        var h = parseInt(lap1.match(/\s(\d{3})\s/g)) - parseInt(lap2.match(
            /\s(\d{3})\s/g));
        if (s < 0.0 || m < 0.0 || h < 0.0) {
            isNeg = true;
        }
        s = Math.abs(s);
        s = s.toFixed(1);
        return [Math.abs(h), Math.abs(m), s, isNeg];
    } else {
        return null;
    }
}

function minlap() {
    if (LAPS.length !== 0) {
        if (LAPS.length === 1) {
            return LAPS[0].substr(8);
        } else {
            var min;
            var ind;
            var laptimes = LAPS.map(function (item, index, array) {
                var s = parseFloat(item.match(/\s(\d{2}\.\d)$/g));
                var m = parseInt(item.match(/\s(\d{2})\s/g)) * 60;
                var h = parseInt(item.match(/\s(\d{3})\s/g)) * 3600;
                var sum = h + m + s;
                if (index === 0) {
                    min = sum;
                    ind = index;
                } else {
                    if (sum < min) {
                        ind = index;
                        min = sum;
                    }
                }
                return sum;
            });
            return LAPS[ind].substr(8);
        }
    } else {
        return null;
    }
}

function maxlap() {
    if (LAPS.length !== 0) {
        if (LAPS.length === 1) {
            return LAPS[0].substr(8);
        } else {
            var min;
            var ind;
            var laptimes = LAPS.map(function (item, index, array) {
                var s = parseFloat(item.match(/\s(\d{2}\.\d)$/g));
                var m = parseInt(item.match(/\s(\d{2})\s/g)) * 60;
                var h = parseInt(item.match(/\s(\d{3})\s/g)) * 3600;
                var sum = h + m + s;
                if (index === 0) {
                    min = sum;
                    ind = index;
                } else {
                    if (sum > min) {
                        ind = index;
                        min = sum;
                    }
                }
                return sum;
            });
            return LAPS[ind].substr(8);
        }
    } else {
        return null;
    }
}

function meanlap() {
    if (LAPS.length !== 0) {
        if (LAPS.length === 1) {
            return minlap();
        } else {
            var laptimes = LAPS.map(function (item, index, array) {
                var s = parseFloat(item.match(/\s(\d{2}\.\d)$/g));
                var m = parseInt(item.match(/\s(\d{2})\s/g)) * 60;
                var h = parseInt(item.match(/\s(\d{3})\s/g)) * 3600;
                return h + m + s;
            });
            var meantime = 0,
                count = LAPS.length;
            while (count--) {
                meantime += laptimes[count];
            }
            meantime = meantime / LAPS.length;
            return displayTimeforHours(parseInt(Math.floor(meantime / 3600))) +
                " : " +
                displayTime(parseInt(Math.floor(meantime / 60) - Math.floor(
                    meantime / 3600) * 60)) + " : " +
                displayTimeforSecs(meantime.toFixed(1) - (Math.floor(meantime /
                    60) - Math.floor(meantime / 3600) * 60) * 60 - Math.floor(
                    meantime / 3600) * 3600);
        }
    } else {
        return null;
    }
}

function totalTime() {
    if (LAPS.length !== 0) {
        if (LAPS.length === 1) {
            return minlap();
        } else {
            var laptimes = LAPS.map(function (item, index, array) {
                var s = parseFloat(item.match(/\s(\d{2}\.\d)$/g));
                var m = parseInt(item.match(/\s(\d{2})\s/g)) * 60;
                var h = parseInt(item.match(/\s(\d{3})\s/g)) * 3600;
                return h + m + s;
            });
            var totaltime = 0,
                count = LAPS.length;
            while (count--) {
                totaltime += laptimes[count];
            }
            return displayTimeforHours(parseInt(Math.floor(totaltime / 3600))) +
                " : " +
                displayTime(parseInt(Math.floor(totaltime / 60) - Math.floor(
                    totaltime / 3600) * 60)) + " : " +
                displayTimeforSecs(totaltime.toFixed(1) - (Math.floor(totaltime /
                            60) -
                        Math.floor(totaltime / 3600) * 60) * 60 -
                    Math.floor(totaltime / 3600) * 3600);
        }
    } else {
        return null;
    }
}
