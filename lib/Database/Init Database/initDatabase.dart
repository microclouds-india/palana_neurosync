import 'package:sqflite/sqflite.dart';

late Database ldb;

initDatabase() async {
  ldb = await openDatabase('offline.db', version: 1,
      onCreate: (Database db, int version) async {
    await db.execute(
        'CREATE TABLE Offline (id INTEGER PRIMARY KEY, audiopath TEXT, tittle TEXT, description TEXT, image TEXT)');
  });
}

addLocalDataBase(String audioPath, String tittle, String description, String image) async {
  await ldb.rawInsert(
      'INSERT INTO Offline(audiopath, tittle, description, image) VALUES(?,?,?,?)',
      [audioPath, tittle, description, image]);
}

deleteData(int id) async {
  await ldb.rawDelete('DELETE FROM Offline WHERE id = ?', [id]);
}

