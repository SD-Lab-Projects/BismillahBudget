/*
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Db{
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> addUser(data,context) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    await users
        .doc(userId)
        .set(data)
        .then((value) => print("User Added"))
        .catchError((error){
      showDialog(
          context: context,
          builder:  (context) {
            return AlertDialog(
              title: Text("Login Error"),
              content: Text(error.toString()),
            );
          }
      );
    });
  }
}

*/
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
//import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:sqflite/sqflite.dart' show getDatabasesPath;
import 'package:sqflite/sqflite.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

/// Local SQLite DB + simple session helper.
class Db {
  static final Db _singleton = Db._internal();
  factory Db() => _singleton;
  Db._internal();

  Database? _db;

  Future<void> init() async {
    if (_db != null) return;

    // SQLite not available on Flutter Web
    if (kIsWeb) {
      debugPrint('[Db.init] Skipped: SQLite is not supported on Flutter Web.');
      throw UnsupportedError('SQLite not supported on web. Run on Android/iOS or add a web store.');
    }

    // Use sqflite’s getDatabasesPath — no path_provider needed
    final dbDir = await getDatabasesPath();
    final dbPath = p.join(dbDir, 'bismillah_budget.db');

    _db = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE users(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          username TEXT,
          email TEXT UNIQUE,
          phone TEXT,
          password_hash TEXT NOT NULL,
          salt TEXT NOT NULL,
          remainingAmount INTEGER NOT NULL DEFAULT 0,
          totalCredit INTEGER NOT NULL DEFAULT 0,
          totalDebit INTEGER NOT NULL DEFAULT 0
        );
      ''');
        await db.execute('''
        CREATE TABLE transactions(
          id TEXT PRIMARY KEY,
          user_id INTEGER NOT NULL,
          title TEXT,
          amount INTEGER NOT NULL,
          type TEXT CHECK(type IN ('credit','debit')) NOT NULL,
          timestamp INTEGER NOT NULL,
          totalCredit INTEGER NOT NULL,
          totalDebit INTEGER NOT NULL,
          remainingAmount INTEGER NOT NULL,
          monthyear TEXT,
          category TEXT,
          FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE
        );
      ''');
      },
    );
  }


  Database get _requireDb {
    final db = _db;
    if (db == null) {
      if (kIsWeb) {
        throw UnsupportedError('SQLite DB unavailable on web. Use Android/iOS or add a web-specific storage.');
      }
      throw StateError('Db not initialized. Call Db().init() in main() first.');
    }
    return db;
  }


  // -------- Password helpers --------
  String _randomSalt([int bytes = 16]) {
    final rand = Random.secure();
    final data = List<int>.generate(bytes, (_) => rand.nextInt(256));
    return base64Url.encode(data);
  }

  String _hashPassword(String password, String salt) {
    final key = utf8.encode('$password:$salt');
    final digest = sha256.convert(key);
    return digest.toString();
  }

  // -------- Session helpers --------
  Future<void> _setCurrentUserId(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('currentUserId', userId);
  }

  Future<void> clearCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('currentUserId');
  }

  Future<int?> getCurrentUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('currentUserId');
  }

  // -------- User operations --------
  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    final db = _requireDb;
    final rows =
    await db.query('users', where: 'email = ?', whereArgs: [email], limit: 1);
    if (rows.isEmpty) return null;
    return rows.first;
  }

  Future<Map<String, dynamic>?> getUserById(int id) async {
    final db = _requireDb;
    final rows =
    await db.query('users', where: 'id = ?', whereArgs: [id], limit: 1);
    if (rows.isEmpty) return null;
    return rows.first;
  }

  // kept for compatibility with your original AuthServices signature
  Future<void> addUser(Map<String, dynamic> data, BuildContext context) async {
    await createUser(data);
  }

  Future<void> createUser(Map<String, dynamic> data) async {
    final db = _requireDb;
    final salt = _randomSalt();
    final hash = _hashPassword(data['password'], salt);
    final user = {
      'username': data['username'],
      'email': data['email'],
      'phone': data['phone'],
      'password_hash': hash,
      'salt': salt,
      'remainingAmount': data['remainingAmount'] ?? 0,
      'totalCredit': data['totalCredit'] ?? 0,
      'totalDebit': data['totalDebit'] ?? 0,
    };
    final id =
    await db.insert('users', user, conflictAlgorithm: ConflictAlgorithm.abort);
    await _setCurrentUserId(id);
  }

  Future<bool> verifyUser(String email, String password) async {
    final row = await getUserByEmail(email);
    if (row == null) return false;
    final salt = row['salt'] as String;
    final expected = row['password_hash'] as String;
    final actual = _hashPassword(password, salt);
    if (actual == expected) {
      await _setCurrentUserId(row['id'] as int);
      return true;
    }
    return false;
  }

  Future<void> updateUserTotals({
    required int userId,
    required int remainingAmount,
    required int totalCredit,
    required int totalDebit,
  }) async {
    final db = _requireDb;
    await db.update(
      'users',
      {
        'remainingAmount': remainingAmount,
        'totalCredit': totalCredit,
        'totalDebit': totalDebit,
      },
      where: 'id = ?',
      whereArgs: [userId],
    );
  }

  Future<Map<String, int>> getUserTotals(int userId) async {
    final user = await getUserById(userId);
    if (user == null) {
      return {'remainingAmount': 0, 'totalCredit': 0, 'totalDebit': 0};
    }
    return {
      'remainingAmount': (user['remainingAmount'] as int?) ?? 0,
      'totalCredit': (user['totalCredit'] as int?) ?? 0,
      'totalDebit': (user['totalDebit'] as int?) ?? 0,
    };
  }

  Future<void> addTransaction(Map<String, dynamic> data) async {
    final db = _requireDb;
    await db.insert('transactions', data,
        conflictAlgorithm: ConflictAlgorithm.abort);
  }

  // (optional) helpers you can use in list widgets:
  Future<List<Map<String, dynamic>>> getTransactionsForUser(int userId,
      {int? limit, int? offset}) async {
    final db = _requireDb;
    return db.query(
      'transactions',
      where: 'user_id = ?',
      whereArgs: [userId],
      orderBy: 'timestamp DESC',
      limit: limit,
      offset: offset,
    );
  }
}
