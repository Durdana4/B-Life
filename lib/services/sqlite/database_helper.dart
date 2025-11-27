import 'dart:async';
import 'package:path/path.dart';
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
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
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

    // --- SAMPLE DATA INSERTION ---
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

    await db.insert('requests', {
      'name': 'Sarah',
      'surname': 'Johnson',
      'bloodType': 'II-',
      'birthDate': '1988-04-05',
      'neededDate': '2025-02-15',
      'disease': 'Diabetes',
      'address': 'Samarkand',
      'contactNumber': '933456789',
      'extraInfo': 'Needs rare blood type'
    });
  }

  // Create
  Future<int> insertRequest(RequestModel request) async {
    final db = await instance.database;
    return await db.insert('requests', request.toMap());
  }

  // Read all
  Future<List<RequestModel>> getAllRequests() async {
    final db = await instance.database;
    final result = await db.query('requests');
    return result.map((e) => RequestModel.fromMap(e)).toList();
  }

  // Read one
  Future<RequestModel?> getRequest(int id) async {
    final db = await instance.database;
    final result =
    await db.query('requests', where: 'id = ?', whereArgs: [id]);

    if (result.isNotEmpty) {
      return RequestModel.fromMap(result.first);
    }
    return null;
  }

  // Update
  Future<int> updateRequest(RequestModel request) async {
    final db = await instance.database;
    return db.update(
      'requests',
      request.toMap(),
      where: 'id = ?',
      whereArgs: [request.id],
    );
  }

  // Delete
  Future<int> deleteRequest(int id) async {
    final db = await instance.database;
    return await db.delete('requests', where: 'id = ?', whereArgs: [id]);
  }
}
