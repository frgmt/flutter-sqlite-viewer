import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import './sqlite_viewer_tables.dart';

class DatabaseList extends StatefulWidget {
  /// open the database viewer in full screen page
  static void open(BuildContext context, {String? path}) {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => DatabaseList(dbPath: path)));
  }

  const DatabaseList({this.dbPath});
  final String? dbPath;
  @override
  _DatabaseListState createState() => _DatabaseListState();
}

class _DatabaseListState extends State<DatabaseList> {
  late Future<List?> _databases;

  @override
  void initState() {
    super.initState();

    _databases = _getDatabases();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("DB")), body: _getWidget(context));
  }

  Future<List?> _getDatabases() async {
    var path = "";
    final dbPath = widget.dbPath;

    if (dbPath != null && dbPath.isNotEmpty) {
      path = dbPath;
    } else {
      path = await getDatabasesPath();
    }

    final dir = Directory(path.toString());
    final databases = dir.listSync();

    if (databases.isNotEmpty) {
      return databases;
    }
    return null;
  }

  FutureBuilder<List?> _getWidget(BuildContext context) {
    return FutureBuilder<List?>(
      future: _databases,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            padding: const EdgeInsets.all(10.0),
            itemCount: snapshot.data?.length ?? 0,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TableList(
                        databasePath: snapshot.data![index].path.toString(),
                      ),
                    ),
                  );
                },
                child: Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(),
                    ),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.folder),
                    title: Text(
                      basename(
                        snapshot.data![index].path.toString(),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
