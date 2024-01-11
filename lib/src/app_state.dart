import 'package:flutter/material.dart';
import 'package:snapgoals_v2/service/database/snapgoals_db.dart';
import 'package:snapgoals_v2/service/models/task.dart';

class AppState extends ChangeNotifier {
  Future<List<Task>>? futureTasks;
  Future<int>? futureTaskNum;
  final snapgoalsDB = SnapgoalsDB();

  void fetchTasks() {
    futureTasks = snapgoalsDB.fetchAll();
  }

  void totalTasks() {
    futureTaskNum = snapgoalsDB.taskNum();
  }

  void notify() {
    notifyListeners();
  }
}
