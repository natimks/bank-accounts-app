import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DbUtil {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'debts_manager.db'),
        onCreate: (db, version) {
      _createDb(db);
    }, version: 2);
  }

  static void _createDb(sql.Database db) {
    db.execute(""" 
    CREATE TABLE account (id INTEGER PRIMARY KEY AUTOINCREMENT,
    title VARCHAR(50), balance REAL)
    """);
    db.execute(
        """CREATE TABLE account_transaction (id INTEGER PRIMARY KEY AUTOINCREMENT,
      type INTEGER, title VARCHAR(50), description VARCHAR(50), transactionDate DATETIME,
      value REAL, account INTEGER,
      FOREIGN KEY (account) REFERENCES account (id))
     """);
  }

  static Future<void> insertData(String table, Map<String, Object> data) async {
    final db = await DbUtil.database();
    await db.insert(table, data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DbUtil.database();
    return db.query(table);
  }

  static Future<List> getDataWhere(
      String table, String whereString, List<dynamic> whereArguments) async {
    final db = await DbUtil.database();
    final data =
        await db.query(table, where: whereString, whereArgs: whereArguments);
    return data.toList();
  }

  static Future<void> executeSQL(String sql, List<dynamic> arguments) async {
    final db = await DbUtil.database();
    db.rawUpdate(sql, arguments);
  }
}
