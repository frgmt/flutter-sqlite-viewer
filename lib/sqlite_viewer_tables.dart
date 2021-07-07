import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import './sqlite_viewer_values.dart';

class TableList extends StatefulWidget {
  final String databasePath;

  const TableList({required this.databasePath});

  @override
  _TableListState createState() => _TableListState();
}

class _TableListState extends State<TableList> {
  late Future<List?> _tables;

  @override
  void initState() {
    super.initState();

    _tables = _getTables();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(basename(widget.databasePath))),
        body: _getWidget(context));
  }

  Future<List?> _getTables() async {
    final db = await openDatabase(widget.databasePath);
    final tables = await db.rawQuery(
        'SELECT name FROM sqlite_master WHERE type = "table" and name != "sqlite_sequence"');
    if (tables.isNotEmpty) {
      return tables;
    }
    return null;
  }

  FutureBuilder<List?> _getWidget(BuildContext context) {
    return FutureBuilder<List?>(
      future: _tables,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            padding: const EdgeInsets.all(10.0),
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DataList(
                        databasePath: widget.databasePath,
                        tableName: snapshot.data![index]["name"].toString(),
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
                      snapshot.data![index]["name"].toString(),
                    ),
                  ),
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
