import 'package:sqflite/sqflite.dart';

import './database_provider.dart';

class TestDatabaseProvider extends DatabaseProvider {
  @override
  String get databaseName => "test.db";

  @override
  String get tableName => "first";

  @override
  createDatabase(Database db, int version) {
    db.execute("""
      CREATE TABLE first(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        column1 TEXT,
        column2 TEXT,
        column3 TEXT,
        created INTEGER DEFAULT (cast(strftime('%s','now') as int))
      );
      """);
    db.execute("""
      CREATE TABLE second(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        column1 TEXT,
        column2 TEXT,
        column3 TEXT,
        created INTEGER DEFAULT (cast(strftime('%s','now') as int))
      );
    """);
  }
}

class Test {
  String column1;
  String column2;
  String column3;
  DateTime? created;

  Test({
    required this.column1,
    required this.column2,
    required this.column3,
  });

  factory Test.fromMap(Map<String, dynamic> map) {
    return Test(
      column1: map['column1'],
      column2: map['column2'],
      column3: map['column3'],
    );
  }

  Map<String, dynamic> toMap() => {
        'column1': column1,
        'column2': column2,
        'column3': column3,
      };
}
