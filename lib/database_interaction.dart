// import 'package:sqflite/sqflite.dart';

// import 'package:sqflite_common_ffi/sqflite_ffi.dart';

// class task {
//   late int id;
//   late String description;
//   late bool completed;
//   late String? image_id;
//   late String? date;
//   late String category;

//   task(this.id, this.description, this.completed, this.image_path, this.date,
//       this.category);

//   task.fromMap(Map<String, Object?> map) {
//     id = map['id'] as int;
//     description = map['description'] as String;
//     completed = map['completed'] == 1;
//     category = map['category'] as String;
//     image_path = map['image_path'] as String;
//     date = map['date'] as String;
//   }

//   Map<String, Object?> toMap() {
//     var map = <String, Object?>{
//       'description': description,
//       'completed': completed == true ? 1 : 0,
//       'image_path': image_path,
//       'date': date,
//       'category': category
//     };
//     map['id'] = id;
//     return map;
//   }
// }

// class taskProvider {
//   taskProvider();

//   late Database db;

//   Future open(String path) async {
//     db = await openDatabase(path, version: 1,
//         onCreate: (Database db, int version) async {
//       await db.execute(
//           "create table tasks (id integer primary key autoincrement, description text not null,completed boolean not null,image_path text, date text, category text not null )");
//     });
//   }

//   Future<task> insert(task todo) async {
//     todo.id = await db.insert('tasks', todo.toMap());
//     return todo;
//   }

//   Future<task?> getTask(int id) async {
//     List<Map<String, Object?>> maps = await db.query('tasks',
//         columns: [
//           'id',
//           'description',
//           'completed',
//           'image_path',
//           'date',
//           'category'
//         ],
//         where: 'id = ?',
//         whereArgs: [id]);
//     if (maps.isNotEmpty) {
//       return task.fromMap(maps.first);
//     }
//     return null;
//   }

//   Future<int> delete(int id) async {
//     return await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
//   }

//   Future<int> update(task todo) async {
//     return await db
//         .update('tasks', todo.toMap(), where: 'id = ?', whereArgs: [todo.id]);
//   }

//   Future close() async => db.close();
// }
