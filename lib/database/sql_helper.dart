import 'package:sqflite/sqflite.dart' as sql;

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
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase('user.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTables(database);
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

  static Future<List<Map<String, dynamic>>> getUser() async {
    final db = await SQLHelper.db();
    return db.query('user');
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
}
