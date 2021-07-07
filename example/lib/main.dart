import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlite_viewer/sqlite_viewer.dart';

import './models/test.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: ThemeData.light(), home: new HomeScreen());
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Sample'),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.folder),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DatabaseList(),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Future<int?> future = _add(
            Test(
              column1: _getRandom(),
              column2: _getRandom(),
              column3: _getRandom(),
            ),
          );
          future
              .then((value) => print(value))
              .catchError((error) => print(error));
        },
      ),
    );
  }

  Future<int?> _add(Test test) async {
    final TestDatabaseProvider provider = TestDatabaseProvider();
    final Database? database = await provider.database;
    return await database?.insert(provider.tableName, test.toMap());
  }

  String _getRandom() {
    const _randomChars =
        "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    const _charsLength = _randomChars.length;

    final rand = new Random();
    final codeUnits = new List.generate(
      20,
      (index) {
        final n = rand.nextInt(_charsLength);
        return _randomChars.codeUnitAt(n);
      },
    );

    return String.fromCharCodes(codeUnits);
  }
}
