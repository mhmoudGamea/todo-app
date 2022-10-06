import 'package:flutter/cupertino.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

const String tableName = 'tasks';

class DBhelper {
  // Access to db and create tasks table
  static Future<sql.Database> createDatabase() async {
    String databasePath = await sql.getDatabasesPath();
    String pathToDatabase = path.join(databasePath, 'todo.db');
    return await sql.openDatabase(pathToDatabase, version: 1, onCreate: (database, version) async {
      return await database.execute(
          'CREATE TABLE $tableName(id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)');
    });
  }

  // Insert into database
  static Future<int> insert(String title, String date, String time) async {
    Database database = await DBhelper.createDatabase();
    late int insertedRowId;
    await database.transaction((txn) async {
      try {
        insertedRowId = await txn.rawInsert(
            'INSERT INTO $tableName (title, date, time, status) VALUES (?, ?, ?, ?)',
            [title, date, time, 'new']);
        print('$insertedRowId row inserted successfully');
      }catch(err) {
        debugPrint(err.toString());
      }
    });
    return insertedRowId;
  }

  // get data from database
  static Future<List<Map<String, dynamic>>> select(String status) async {
    Database database = await DBhelper.createDatabase();
    return await database.rawQuery('SELECT * FROM $tableName WHERE status = ?', [status]);
  }

  // update data in database
  static Future<void> update(String status, int id) async{
    Database database = await DBhelper.createDatabase();
    await database.rawUpdate('UPDATE $tableName SET status = ? WHERE id = ?', [status , id]);
  }
  
  // delete data from database
  static Future<void> delete(int id) async {
    Database database = await DBhelper.createDatabase();
    await database.rawDelete('DELETE FROM $tableName WHERE id = ?', [id]);
  }
}
