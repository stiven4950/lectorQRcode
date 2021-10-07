import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:qr_reader/models/scan_model.dart';

class DBProvider {
  final String databaseName = 'ScansDB.db';
  static Database? _database;

  static final DBProvider db = DBProvider._();

  DBProvider._();

  get database async {
    if (_database != null) return _database;

    _database = await initDB();

    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentsDirectory.path, databaseName);

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute('''CREATE TABLE scan(
          id INTEGER PRIMARY KEY,
          type TEXT,
          value TEXT
        )''');
      },
    );
  }

  // Inserting

  Future<int> newScanRow(ScanModel newScan) async {
    final id = newScan.id;
    final type = newScan.type;
    final value = newScan.value;

    final Database db = await database;
    final response = await db.rawInsert(
      '''INSERT INTO scan (id,type,value) VALUES ($id,"$type", "$value")''',
    );
    return response;
  }

  Future<int> newScan(ScanModel newScan) async {
    final Database db = await database;

    final response = await db.insert('scan', newScan.toJson());

    return response;
  }

  // Obtaining
  Future<ScanModel> getScanId(int id) async {
    final Database db = await database;
    // En la cadena que se pasa a where se especifican todas las condiciones que se deseen.
    final response = await db.query('scan', where: 'id=?', whereArgs: [id]);
    return ScanModel.fromJson(response.first);
  }

  Future<List<ScanModel>> getAll() async {
    final Database db = await database;
    final response = await db.query('scan');

    List<ScanModel> list = response.isNotEmpty
        ? response.map((e) => ScanModel.fromJson(e)).toList()
        : [];

    return list;
  }

  Future<List<ScanModel>> getAllIf(String type) async {
    final Database db = await database;
    final response =
        await db.rawQuery("SELECT * FROM scan WHERE type ='$type'");

    List<ScanModel> list = response.isNotEmpty
        ? response.map((e) => ScanModel.fromJson(e)).toList()
        : [];

    return list;
  }

  // Updating
  Future<int> updateScan(ScanModel scan) async {
    final Database db = await database;
    final response = await db
        .update('scan', scan.toJson(), where: 'id=?', whereArgs: [scan.id]);

    return response;
  }

  // Deleting
  Future<int> deleteScan(int id) async {
    final Database db = await database;
    final response = await db.delete('scan', where: 'id=?', whereArgs: [id]);
    return response;
  }

  Future<int> deleteAll() async {
    final Database db = await database;
    final response = await db.rawDelete('DELETE FROM scan');

    return response;
  }
}
