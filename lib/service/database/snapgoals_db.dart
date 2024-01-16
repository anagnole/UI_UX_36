import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:snapgoals_v2/service/database/database_service.dart';
import 'package:snapgoals_v2/service/models/key_word.dart';
import 'package:snapgoals_v2/service/models/task.dart';
import 'package:sqflite/sqflite.dart';

class SnapgoalsDB {
  final tableName = 'tasks';
  final tableKeyWords = 'keyWords';
  final relationship = 'relationship';

  Future<void> createTable(Database database) async {
    //await database.execute("DROP TABLE $tableName;");
    //await database.execute("DROP TABLE $tableKeyWords;");
    // await database.rawDelete('''DELETE FROM $tableName''');
    // await database.rawDelete('''DELETE FROM $tableKeyWords''');
    await database.execute(""" CREATE TABLE IF NOT EXISTS $tableName (
      "id" INTEGER NOT NULL,
      "title" TEXT NOT NULL,
      "category" TEXT NOT NULL,
      "picture" BLOB, 
      "location" TEXT NOT NULL,
      "completed" INTEGER NOT NULL,
      "created_at" INTEGER NOT NULL DEFAULT (cast(strftime('%s','now') as int)),
      "updated_at" INTEGER,
      PRIMARY KEY("id" AUTOINCREMENT)
    );""");

    await database.execute(""" CREATE TABLE IF NOT EXISTS $relationship (
      "id" INTEGER NOT NULL,
      "task_id" INTEGER NOT NULL,
      "key_id" INTEGER NOT NULL,
      FOREIGN KEY("key_id") REFERENCES $tableKeyWords("id"),
      FOREIGN KEY("task_id") REFERENCES $tableName("id"),
      PRIMARY KEY("id" AUTOINCREMENT)
    );""");

    await database.execute(""" CREATE TABLE IF NOT EXISTS $tableKeyWords (
      "id" INTEGER NOT NULL,
      "word" TEXT NOT NULL UNIQUE,
      "category" TEXT NOT NULL,
      PRIMARY KEY("id" AUTOINCREMENT)
    );""");

    List<String> arrayFitness = [
      'Bicycle',
      'Stadium',
      'Swimwear',
      'Cycling',
      'Soccer',
      'Gymnastics',
      'Musle',
      'Pool',
      'Running',
      'Sports',
      'Shoe',
      'Swimming'
    ];
    List<String> arrayStudy = [
      'Computer',
      'Chair',
      'Desk',
      'Web page',
      'Paper'
    ];
    List<String> arraySocial = [
      'Selfie',
      'Team',
      'Cheeseburger',
      'Beard',
      'Park',
      'Fast food',
      'Eating',
      'Person',
      'Laugh',
      'Nightclub',
      'Dude',
      'Menu',
      'Cola',
      'Coffee',
      'Food',
      'Pizza',
      'Cappucino'
    ];

    for (String word in arrayFitness) {
      await database.rawInsert(
        '''INSERT INTO $tableKeyWords (word, category) VALUES (?,?);''',
        [
          word,
          'fitness',
        ],
      );
    }
    for (String word in arraySocial) {
      await database.rawInsert(
        '''INSERT INTO $tableKeyWords (word, category) VALUES (?,?);''',
        [
          word,
          'social',
        ],
      );
    }
    for (String word in arrayStudy) {
      await database.rawInsert(
        '''INSERT INTO $tableKeyWords (word, category) VALUES (?,?);''',
        [
          word,
          'study',
        ],
      );
    }
  }

  Future<int> createTask({
    required String title,
    required String category,
    required Uint8List picture,
    required String location,
    required List<int> keyIds,
  }) async {
    final database = await DatabaseService().database;
    int taskId = await database.rawInsert(
      '''INSERT INTO $tableName (title, category, picture, location, completed, created_at) VALUES (?,?,?,?,?,?)''',
      [
        title,
        category,
        picture,
        location,
        0,
        DateTime.now().millisecondsSinceEpoch
      ],
    );
    for (int keyId in keyIds) {
      await database.rawInsert(
        '''INSERT INTO $relationship (task_id, key_id) VALUES (?,?)''',
        [taskId, keyId],
      );
    }

    return 0;
  }

  Future<List<KeyWord>> fetchTaskKeyWords({required int taskId}) async {
    final database = await DatabaseService().database;
    final keyWords = await database.rawQuery(
        '''SELECT key.id, key.word, key.category FROM $tableKeyWords as key INNER JOIN $relationship as r ON r.key_id = key.id WHERE r.task_id = ? ''',
        [taskId]);
    print(keyWords.length);
    return keyWords.map((key) => KeyWord.fromSqfliteDatabase(key)).toList();
  }

  Future<List<KeyWord>> fetchCategoryKeyWords(
      {required String category}) async {
    final database = await DatabaseService().database;
    final keyWords = await database.rawQuery(
        '''SELECT * FROM $tableKeyWords WHERE category = ? ''', [category]);
    return keyWords.map((key) => KeyWord.fromSqfliteDatabase(key)).toList();
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
    //final database = await db;
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

  Future<int> update(
      {required int id,
      required String location,
      required Uint8List picture}) async {
    final database = await DatabaseService().database;
    return await database.update(
      tableName,
      {
        'location': location,
        'picture': picture,
        'completed': 1,
        'updated_at': DateTime.now().microsecondsSinceEpoch,
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
