import 'package:sqflite/sqflite.dart';

late Database alamyDatabase;

initAlamyDatabase() async {
  alamyDatabase = await openDatabase('alamyview.db', version: 1,
      onCreate: (Database db, int version) async {
    await db.execute(
        'CREATE TABLE alamyview (id INTEGER PRIMARY KEY, time TEXT, reminder TEXT, date TEXT)');
  });
}

addAlamyLocalDataBase(String time, String reminder, String date) async {
  await alamyDatabase.rawInsert(
      'INSERT INTO alamyview(time, reminder, date) VALUES(?,?,?)',
      [time, reminder, date]);
}
