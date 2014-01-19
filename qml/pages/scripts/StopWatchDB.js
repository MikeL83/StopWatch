// StopWatchDB.js

//making the StopWatchDB.js a stateless library
.import QtQuick.LocalStorage 2.0 as Sql
.pragma library

var db;

function openDB() {
    db = Sql.LocalStorage.openDatabaseSync("StopWatchDB","1.0","StopWatch Database",1e5);
    createTable();
}

function createTable() {
    db.transaction( function(tx) {
        tx.executeSql("CREATE TABLE IF NOT EXISTS\
           logbook (Id INTEGER PRIMARY KEY AUTOINCREMENT,\
           starttime TEXT,\
           totaltime TEXT,\
           minlap TEXT,\
           maxlap TEXT,\
           meanlap TEXT,\
           numoflaps TEXT,\
           title TEXT,\
           note TEXT)");
    });
}

function saveLap(starttime,totalTime,minlap,maxlap,meanlap,numoflaps,title,note) {
    db.transaction( function(tx) {
        tx.executeSql("INSERT INTO logbook (starttime,totaltime,minlap,maxlap,meanlap,numoflaps,title,note) VALUES(?,?,?,?,?,?,?,?)",
           [starttime,totalTime,minlap,maxlap,meanlap,numoflaps,title,note]
        );
    });
}

function readLogbook() {
    var data = [];
    db.readTransaction( function(tx) {
       var rs = tx.executeSql("SELECT * FROM logbook ORDER BY starttime DESC");
       var i = 0, count = rs.rows.length;
       for (; i < count; i++) {
           data[i] = rs.rows.item(i);
        }
    });
    return data;
}

function deleteAll() {
    db.transaction( function(tx) {
       tx.executeSql("\
          DELETE FROM logbook");
    });
}
function deleteRecord(time) {
    db.transaction( function(tx) {
       tx.executeSql("\
          DELETE FROM logbook WHERE starttime=?",[time]);
    });
}

function updateTitleAndNote(time,title,note) {
    db.transaction( function(tx) {
       tx.executeSql("\
          UPDATE logbook SET title=?, note=? WHERE starttime=?",[title,note,time]);
    });
}


