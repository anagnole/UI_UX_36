import 'package:flutter/material.dart';
import 'package:snapgoals_v2/service/database/snapgoals_db.dart';
import 'package:snapgoals_v2/service/models/task.dart';

class AppState extends ChangeNotifier {
  Future<List<Task>>? futureTasks;
  final snapgoalsDB = SnapgoalsDB();

  void fetchTasks() {
    futureTasks = snapgoalsDB.fetchAll();
  }

  void notify() {
    notifyListeners();
  }
}
