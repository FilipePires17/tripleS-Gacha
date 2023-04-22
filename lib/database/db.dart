import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DB {
  DB._();
  static final DB instance = DB._();
  static Database? _database;

  Future<Database> get database async {
    return _database ??= await initDatabase();
  }

  static get() async {
    return await DB.instance.database;
  }

  initDatabase() async {
    return await openDatabase(join(await getDatabasesPath(), 'cosmo.db'),
        version: 2, onCreate: ((db, version) async {
      await db.execute(objekts);
      await db.execute(inventory);
      await setupObjekts(db);
    }));
  }

  addTestInv(db) async {
    await db.insert('inventory', {'serial': 1, 'obj_id': 1});
    await db.insert('inventory', {'serial': 1, 'obj_id': 56});
    await db.insert('inventory', {'serial': 1, 'obj_id': 35});
  }

  String get objekts => '''
    CREATE TABLE objekts(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      class_num TEXT,
      s TEXT,
      class TEXT,
      url TEXT
    );
  ''';

  String get inventory => '''
    CREATE TABLE inventory(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      serial INTEGER,
      created DATETIME,
      obj_id INTEGER,
      FOREIGN KEY (obj_id) REFERENCES objekts(id)
    );
  ''';

  Future<File> getFileFromAssets(String path) async {
    final byteData = await rootBundle.load('assets/$path');

    final file = File('${(await getTemporaryDirectory()).path}/$path');
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }

  setupObjekts(db) async {
    final file = await getFileFromAssets('objekts.csv');

    //final File file = File('assets\\objekts.csv');
    final String csvString = await file.readAsString();
    // print(csvString);

    // Converta o conteúdo do arquivo CSV em uma lista de linhas
    final List<List<dynamic>> csvTable =
        CsvToListConverter().convert(csvString);
    csvTable.removeAt(0);
    for (final List<dynamic> row in csvTable) {
      await db.insert('objekts',
          {'class_num': row[0], 's': row[1], 'class': row[2], 'url': row[3]});
    }
  }
}
