import 'dart:typed_data';

import 'package:flutter/foundation.dart';
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
      "picture" BLOB, 
      "completed" INTEGER NOT NULL,
      "created_at" INTEGER NOT NULL DEFAULT (cast(strftime('%s','now') as int)),
      "updated_at" INTEGER,
      PRIMARY KEY("id" AUTOINCREMENT)
    );""");
  }

  Future<int> create(
      {required String title,
      required String category,
      required Uint8List picture,
      String description = ''}) async {
    final database = await DatabaseService().database;
    return await database.rawInsert(
      '''INSERT INTO $tableName (title, category, picture, description, completed, created_at) VALUES (?,?,?,?,?,?)''',
      [
        title,
        category,
        picture,
        description,
        0,
        DateTime.now().millisecondsSinceEpoch
      ],
    );
  }

  Future<List<Task>> fetchAll() async {
    final database = await DatabaseService().database;
    final tasks = await database.rawQuery(
        '''SELECT * FROM $tableName ORDER BY COALESCE(updated_at, created_at) ''');
    return tasks.map((task) => Task.fromSqfliteDatabase(task)).toList();
  }

  Future<List<Task>> fetchNonCompleted() async {
    final database = await DatabaseService().database;
    final tasks = await database.rawQuery(
        '''SELECT * FROM $tableName  WHERE completed = ? ORDER BY COALESCE(updated_at, created_at) ''',
        [0]);
    return tasks.map((task) => Task.fromSqfliteDatabase(task)).toList();
  }

  Future<List<Task>> fetchCompleted() async {
    final database = await DatabaseService().database;
    final tasks = await database.rawQuery(
        '''SELECT * FROM $tableName  WHERE completed = ? ORDER BY COALESCE(updated_at, created_at) ''',
        [1]);
    return tasks.map((task) => Task.fromSqfliteDatabase(task)).toList();
  }

  Future<List<int>> taskNumByCategory() async {
    final database = await DatabaseService().database;

    List<int> counts = [];

    for (String value in ['fitness', 'social', 'study']) {
      final List<Map<String, dynamic>> result = await database.rawQuery(
        '''SELECT COUNT(*) as count FROM $tableName WHERE category = ? and completed = ?''',
        [value, 1],
      );

      if (result.isNotEmpty) {
        int count = int.tryParse(result.first['count'].toString()) ?? 0;
        counts.add(count);
      } else {
        counts.add(0);
      }
    }

    return counts;
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
  Future<int> update({required int id, required Uint8List picture}) async {
    final database = await DatabaseService().database;
    return await database.update(
      tableName,
      {
        'picture': picture,
        'completed': 1,
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

  Future<void> deleteAll() async {
    final database = await DatabaseService().database;
    await database.rawDelete('''DELETE FROM $tableName''');
  }
}
