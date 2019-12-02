import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import './sqlite_viewer_values.dart';

class TableList extends StatefulWidget {
  final String databasePath;

  TableList({@required this.databasePath});

  @override
  _TableListState createState() => _TableListState(databasePath: databasePath);
}

class _TableListState extends State<TableList> {
  final String databasePath;
  Future<List> _tables;

  _TableListState({
    @required this.databasePath,
  });

  @override
  void initState() {
    super.initState();

    _tables = _getTables();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(basename(databasePath))),
        body: _getWidget(context));
  }

  Future<List> _getTables() async {
    final db = await openDatabase(databasePath);
    final tables = await db.rawQuery(
        'SELECT name FROM sqlite_master WHERE type = "table" and name != "sqlite_sequence"');
    if (tables.length > 0) {
      return tables;
    }
    return null;
  }

  FutureBuilder<List> _getWidget(BuildContext context) {
    return FutureBuilder<List>(
        future: _tables,
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
                          title: Text(snapshot.data[index]["name"]),
                        ),
                        decoration: new BoxDecoration(
                            border: new Border(bottom: new BorderSide()))),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => DataList(
                                  databasePath: databasePath,
                                  tableName: snapshot.data[index]["name"])));
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
