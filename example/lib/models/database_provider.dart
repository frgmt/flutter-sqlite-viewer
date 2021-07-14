import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

abstract class DatabaseProvider {
  Database? _instance;

  String get databaseName;

  String get tableName;

  Future<Database?> get database async {
    if (_instance == null) {
      var path = await getDatabasesPath();
      _instance = await openDatabase(
        join(
          path,
          databaseName,
        ),
        onCreate: createDatabase,
        version: 1,
      );
    }
    return _instance;
  }

  createDatabase(Database db, int version);
}
