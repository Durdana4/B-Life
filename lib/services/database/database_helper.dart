import 'dart:async';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';
import '../../models/request.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('blife.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = p.join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    print("DATABASE CREATED!");

    await db.execute('''
    CREATE TABLE requests(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      surname TEXT,
      bloodType TEXT,
      birthDate TEXT,
      neededDate TEXT,
      disease TEXT,
      address TEXT,
      contactNumber TEXT,
      extraInfo TEXT
    )
    ''');

    await db.insert('requests', {
      'name': 'Emily',
      'surname': 'Thompson',
      'bloodType': 'I+',
      'birthDate': '1997-08-12',
      'neededDate': '2025-02-10',
      'disease': 'None',
      'address': 'Tashkent',
      'contactNumber': '901234567',
      'extraInfo': 'Urgent case'
    });
  }

  Future<int> insertRequest(RequestModel request) async {
    final db = await instance.database;
    return await db.insert('requests', request.toMap());
  }

  Future<List<RequestModel>> getAllRequests() async {
    final db = await instance.database;
    final result = await db.query('requests');
    return result.map((e) => RequestModel.fromMap(e)).toList();
  }

  Future<RequestModel?> getRequest(int id) async {
    final db = await instance.database;
    final result =
    await db.query('requests', where: 'id = ?', whereArgs: [id]);

    if (result.isNotEmpty) {
      return RequestModel.fromMap(result.first);
    }
    return null;
  }

  Future<int> updateRequest(RequestModel request) async {
    final db = await instance.database;
    return db.update(
      'requests',
      request.toMap(),
      where: 'id = ?',
      whereArgs: [request.id],
    );
  }

  Future<int> deleteRequest(int id) async {
    final db = await instance.database;
    return await db.delete('requests', where: 'id = ?', whereArgs: [id]);
  }
}
