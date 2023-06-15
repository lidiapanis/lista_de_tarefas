import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:listatarefas/services/task_service.dart';
import '../models/task.dart';

class TasksProvider with ChangeNotifier {
  List<Task> itens = [];

  Future<List<Task>> list() async {
    if (itens.isEmpty) {
      return await TaskService().list();
    }
    notifyListeners();
    return itens;
  }

  Future<void> insert(Task task) async {
    await TaskService().insert(task);
    await refresh();
    notifyListeners();
  }

  void delete(Task task) async {
    String id = task.id.toString();
    bool isDeleted = await TaskService().delete(id);
    if (isDeleted) {
      itens.remove(task);
      notifyListeners();
    }
  }

  Future<void> refresh() async {
    itens = await TaskService().list();
    notifyListeners();
  }
}
