import 'package:flutter/material.dart';
import 'package:snapgoals_v2/service/database/snapgoals_db.dart';
import 'package:snapgoals_v2/service/models/key_word.dart';
import 'package:snapgoals_v2/service/models/task.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppState extends ChangeNotifier {
  Future<List<Task>>? futureTasks;

  Future<List<Task>>? futureNonCompletedTasks;
  Future<List<Task>>? futureCompletedTasks;
  Future<List<int>>? futureTaskNumByCategory;
  Future<int>? futureTaskNum;
  Future<List<KeyWord>>? futureKeyWordsByCategory;
  Future<SharedPreferences>? prefs = SharedPreferences.getInstance();
  String? name;
  List<int> chosenKeyWords = [];
  bool retake = true;

  final snapgoalsDB = SnapgoalsDB();

  void fetchKeyWordsByCategory(String category) {
    futureKeyWordsByCategory =
        snapgoalsDB.fetchCategoryKeyWords(category: category);
  }

  void fetchTasks() {
    futureTasks = snapgoalsDB.fetchAll();
  }

  void fetchNonCompletedTasks() {
    futureNonCompletedTasks = snapgoalsDB.fetchNonCompleted();
  }

  void fetchCompletedTasks() {
    futureCompletedTasks = snapgoalsDB.fetchCompleted();
  }

  void totalTasksByCategory() {
    futureTaskNumByCategory = snapgoalsDB.taskNumByCategory();
  }

  void totalTasks() {
    futureTaskNum = snapgoalsDB.taskNum();
  }

  void setName(String newName) {
    name = newName;
  }

  void notify() {
    notifyListeners();
  }
}
