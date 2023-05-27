import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlDb {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDb();
      return _db;
    } else {
      return _db;
    }
  }

  initialDb() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'todo_app.db');
    Database mydb = await openDatabase(path,
        onCreate: _onCreate, version: 1, onUpgrade: _onUpgrade);
    return mydb;
  }

  _onUpgrade(Database db, int oldversion, int newversion) async {
    db.execute(
        'ALTER TABLE test ADD COLUMN age REAL'); //for example if wanna edit the database and add something to it..
    //we just have to change the version number if we wanna excute it ..
    print('onUpgrade....................');
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
CREATE TABLE "tasks"(
"id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
"task" TEXT NOT NULL,
"time" TEXT NOT NULL,
"date" TEXT NOT NULL,
"status" TEXT NOT NULL
)
''').then((value) => print('database and table created................... '));
  }

  readData(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

  insertData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }

  updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  deleteData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }

  // this function is to delete the database of yours .. you can just call this function or copy it and edit the path ("test.db") to your own database path..
  _deleteDataBase(String sql) async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'todo_app.db');
    await deleteDatabase(path);
  }
}
