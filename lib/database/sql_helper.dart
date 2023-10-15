import 'package:sqflite/sqflite.dart' as sql;
import 'package:transportasi_11/data/ticket.dart';

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""
      CREATE TABLE user(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        name TEXT,
        email TEXT,
        password TEXT,
        fullName TEXT,
        noTelp TEXT     )

      
    """);
    await database.execute("""
    CREATE TABLE ticket(
        idTicket INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        tujuan TEXT,
        asal TEXT,
        harga INTEGER,
        jenis TEXT,
        gambar TEXT
      )
      """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase('user.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTables(database);
    }, onConfigure: (sql.Database database) async {
      await database.execute('PRAGMA foreign_keys = ON');
    });
  }

  static Future<int> addUser(String name, String email, String password,
      String noTelp, String fullName) async {
    final db = await SQLHelper.db();
    final data = {
      'name': name,
      'email': email,
      'password': password,
      'noTelp': noTelp,
      'fullName': fullName
    };
    return await db.insert('user', data);
  }

  static Future<int> addTicket(String asal, String tujuan, int harga,
      String jenis, String gambar) async {
    final db = await SQLHelper.db();
    final data = {
      'asal': asal,
      'tujuan': tujuan,
      'harga': harga,
      'jenis': jenis,
      'gambar': gambar
    };
    return await db.insert('ticket', data);
  }

  static Future<List<Map<String, dynamic>>> getUser() async {
    final db = await SQLHelper.db();
    return db.query('user');
  }

  static Future<List<Map<String, dynamic>>> getTicket() async {
    final db = await SQLHelper.db();
    return db.query('ticket');
  }

  static Future<int> editTicket(int idTicket, String asal, String tujuan,
      int harga, String jenis, String gambar) async {
    final db = await SQLHelper.db();
    final data = {
      'asal': asal,
      'tujuan': tujuan,
      'harga': harga,
      'jenis': jenis,
      'gambar': gambar,
    };
    return await db.update('ticket', data, where: "idTicket = $idTicket");
  }

  static Future<int> editUser(int id, String name, String email,
      String password, String noTelp, String fullName) async {
    final db = await SQLHelper.db();
    final data = {
      'name': name,
      'email': email,
      'password': password,
      'noTelp': noTelp,
      'fullName': fullName
    };
    return await db.update('user', data, where: "id = $id");
  }

  static Future<int> deleteEmployee(int id) async {
    final db = await SQLHelper.db();
    return await db.delete('user', where: "id = $id");
  }

  static Future<int> deleteTicket(int idTicket) async {
    final db = await SQLHelper.db();
    return await db.delete('ticket', where: "idTicket = $idTicket");
  }

  static Future<bool> emailUnique(String email) async {
    final db = await SQLHelper.db();
    final result = await db.query('user', where: "email =" '$email');
    return false;
  }
}
