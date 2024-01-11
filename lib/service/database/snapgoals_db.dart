import 'package:snapgoals_v2/service/database/database_service.dart';
import 'package:snapgoals_v2/service/models/task.dart';
import 'package:sqflite/sqflite.dart';

class SnapgoalsDB {
  final tableName = 'tasks';

  Future<void> createTable(Database database) async {
    //await database.execute("DROP TABLE $tableName;");
    await database.execute(""" CREATE TABLE IF NOT EXISTS $tableName (
      "id" INTEGER NOT NULL,
      "title" TEXT NOT NULL,
      "description" TEXT NOT NULL,
      "category" TEXT NOT NULL,
      "created_at" INTEGER NOT NULL DEFAULT (cast(strftime('%s','now') as int)),
      "updated_at" INTEGER,
      PRIMARY KEY("id" AUTOINCREMENT)
    );""");
  }

  Future<int> create(
      {required String title,
      required String category,
      String description = ''}) async {
    final database = await DatabaseService().database;
    return await database.rawInsert(
      '''INSERT INTO $tableName (title, category, description, created_at) VALUES (?,?,?,?)''',
      [title, category, description, DateTime.now().millisecondsSinceEpoch],
    );
  }

  Future<List<Task>> fetchAll() async {
    final database = await DatabaseService().database;
    final tasks = await database.rawQuery(
        '''SELECT * FROM $tableName ORDER BY COALESCE(updated_at, created_at) ''');
    return tasks.map((task) => Task.fromSqfliteDatabase(task)).toList();
  }

  Future<int> taskNum() async {
    final database = await DatabaseService().database;

    final List<Map<String, dynamic>> result =
        await database.rawQuery('''SELECT COUNT(*) as count FROM $tableName''');

    if (result.isNotEmpty) {
      return int.tryParse(result.first.toString()) ?? 0;
    }
    return 0;
  }

  Future<Task> fetchById(int id) async {
    final database = await DatabaseService().database;
    final task = await database
        .rawQuery('''SELECT * FROM $tableName WHERE id = ?''', [id]);
    return Task.fromSqfliteDatabase(task.first);
  }

//maybe remove??
  Future<int> update({required int id, String? title}) async {
    final database = await DatabaseService().database;
    return await database.update(
      tableName,
      {
        if (title != null) 'title': title,
        'updated_at': DateTime.now().millisecondsSinceEpoch,
      },
      where: 'id = ?',
      conflictAlgorithm: ConflictAlgorithm.rollback,
      whereArgs: [id],
    );
  }

  Future<void> delete(int id) async {
    final database = await DatabaseService().database;
    await database.rawDelete('''DELETE FROM $tableName WHERE id = ?''', [id]);
  }
}
