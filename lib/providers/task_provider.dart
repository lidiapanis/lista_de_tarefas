import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../models/task.dart';
import '../services/task_service.dart';

class TasksProvider with ChangeNotifier {
  final List<Task> itens = [];

  Future<List<Task>> getAll() async {
    return await TaskService().getAll();
  }

  void delete(Task task) async {
    bool isDeleted = await TaskService().delete(task);
    if (isDeleted) {
      itens.remove(task);
      notifyListeners();
    }
  }
}
