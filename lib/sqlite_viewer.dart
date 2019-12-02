import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import './sqlite_viewer_tables.dart';

class DatabaseList extends StatefulWidget {
  @override
  _DatabaseListState createState() => _DatabaseListState();
}

class _DatabaseListState extends State<DatabaseList> {
  Future<List> _databases;

  @override
  void initState() {
    super.initState();

    _databases = _getDatabases();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("DB")), body: _getWidget(context));
  }

  Future<List> _getDatabases() async {
    final path = await getDatabasesPath();
    final dir = new Directory(path.toString());
    final databases = dir.listSync();
    if (databases.length > 0) {
      return databases;
    }
    return null;
  }

  FutureBuilder<List> _getWidget(BuildContext context) {
    return FutureBuilder<List>(
        future: _databases,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                padding: EdgeInsets.all(10.0),
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    child: Container(
                        child: ListTile(
                          leading: Icon(Icons.folder),
                          title: Text(basename(snapshot.data[index].path)),
                        ),
                        decoration: new BoxDecoration(
                            border: new Border(bottom: new BorderSide()))),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => TableList(
                                  databasePath: snapshot.data[index].path)));
                    },
                  );
                });
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          return Text("");
        });
  }
}
