import 'dart:convert';
import 'package:listatarefas/models/task.dart';
import 'package:http/http.dart';
import 'package:listatarefas/repositories/tasks_repository.dart';

class TaskService {
  final TaskRepository _tasksRepository = TaskRepository();

  Future<List<Task>> getAll() async {
    try {
      Response response = await _tasksRepository.getAll();

      Map<String, dynamic> json = jsonDecode(response.body);
      return Task.listFromJson(json);
    } catch (err) {
      print(err);
      throw Exception("Problemas ao consultar lista de tarefas.");
    }
  }

  Future<Response> insert(Task task) async {
    try {
      String json = jsonEncode(task.toJson());
      return await _tasksRepository.insert(json);
    } catch (err) {
      throw Exception("Problemas ao consultar lista de tarefas.");
    }
  }

  Future<Response> update(Task task, String? id) async {
    try {
      return await _tasksRepository.update(task.name, task.location);
    } catch (err) {
      throw Exception("Problema ao atualizar a tarefa selecionada.");
    }
  }

  Future<bool> delete(Task task) async {
    try {
      Response response = await _tasksRepository.delete(task.name);

      return response.statusCode == 200;
    } catch (err) {
      throw Exception("Problema ao deletar a tarefa selecionada.");
    }
  }
}
