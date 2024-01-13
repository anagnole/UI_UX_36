import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snapgoals_v2/service/database/snapgoals_db.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initialize();
    return _database!;
  }

  Future<String> get fullPath async {
    const name = 'snapgoals.db';
    final path = await getDatabasesPath();
    return join(path, name);
  }

  Future<Database> _initialize() async {
    final path = await fullPath;
    var database = await openDatabase(
      path,
      version: 1,
      onCreate: create,
      singleInstance: true,
    );

    await SnapgoalsDB().createTable(database);

    return database;
  }

  Future<void> create(Database database, int version) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('name', 'George');
    await SnapgoalsDB().createTable(database);
  }
}
