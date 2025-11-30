import 'dart:async';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

import '../../models/request.dart';
import '../../models/user_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  // ============================================================
  // GET DATABASE INSTANCE
  // ============================================================
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('blife.db');
    return _database!;
  }

  // ============================================================
  // INIT DB
  // ============================================================
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = p.join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 2,
      onCreate: _createDB,
      onUpgrade: _upgradeDB,
    );
  }

  // ============================================================
  // CREATE TABLES
  // ============================================================
  Future _createDB(Database db, int version) async {
    print("DATABASE CREATED!");

    // ------------------ REQUESTS TABLE ------------------
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

    // Insert sample request
    await db.insert('requests', {
      'name': 'Emily',
      'surname': 'Thompson',
      'bloodType': 'I+',
      'birthDate': '1997-08-12',
      'neededDate': '2025-02-10',
      'disease': 'None',
      'address': 'Tashkent',
      'contactNumber': '901234567',
      'extraInfo': 'Urgent case',
    });

    // ------------------ USERS TABLE ------------------
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        surname TEXT,
        email TEXT UNIQUE,
        phone TEXT,
        location TEXT,
        password TEXT,
        bloodType TEXT,
        gender TEXT,
        passportId TEXT,
        isEligible INTEGER,
        nextDonationDate TEXT,
        totalDonations INTEGER
      )
    ''');

    // Insert DEFAULT USER (ID = 1)
    await db.insert('users', {
      'name': 'Jamol',
      'surname': 'Shoymurzaev',
      'email': 'jamol@example.com',
      'phone': '+998 90 123 45 67',
      'location': 'Tashkent',
      'password': '123456', // You can change later
      'bloodType': 'I+',
      'gender': 'Male',
      'passportId': 'AA1234567',
      'isEligible': 1,
      'nextDonationDate': '2024-12-20',
      'totalDonations': 3,
    });

    print("DEFAULT USER INSERTED");
  }

  // ============================================================
  // UPGRADE DATABASE (if schema changes)
  // ============================================================
  Future _upgradeDB(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      print("UPGRADING DB → Adding users table");

      await db.execute('''
        CREATE TABLE IF NOT EXISTS users(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          surname TEXT,
          email TEXT UNIQUE,
          phone TEXT,
          location TEXT,
          password TEXT,
          bloodType TEXT,
          gender TEXT,
          passportId TEXT,
          isEligible INTEGER,
          nextDonationDate TEXT,
          totalDonations INTEGER
        )
      ''');
    }
  }

  // ============================================================
  // REQUEST CRUD
  // ============================================================
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
    return await db.update(
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

  // ============================================================
  // USER CRUD
  // ============================================================
  Future<int> insertUser(UserModel user) async {
    final db = await instance.database;
    return await db.insert('users', user.toMap());
  }

  Future<UserModel?> getUserByEmail(String email) async {
    final db = await instance.database;
    final result =
    await db.query('users', where: 'email = ?', whereArgs: [email]);

    if (result.isNotEmpty) {
      return UserModel.fromMap(result.first);
    }
    return null;
  }

  Future<UserModel?> getUserById(int id) async {
    final db = await instance.database;

    final result =
    await db.query('users', where: 'id = ?', whereArgs: [id]);

    if (result.isNotEmpty) {
      return UserModel.fromMap(result.first);
    }
    return null;
  }

  Future<int> updateUser(UserModel user) async {
    final db = await instance.database;

    return await db.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<int> updatePassword(int id, String newPass) async {
    final db = await instance.database;

    return await db.update(
      'users',
      {"password": newPass},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
