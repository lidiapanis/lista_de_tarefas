import 'dart:convert';
import 'package:http/http.dart';
import 'package:listatarefas/models/task.dart';
import 'package:listatarefas/repositories/tasks_repository.dart';
import 'package:listatarefas/screens/task_insert_screen.dart';

class TaskService {
  final TaskRepository taskRepository = TaskRepository();

  Future<List<Task>> list() async {
    try {
      Response response = await taskRepository.list();

      if (response.statusCode == 200) {
        if ((response.body != null) && (response.body.isNotEmpty)) {
          var parsed = jsonDecode(response.body);
          if (parsed is Map<String, dynamic>) {
            Map<String, dynamic> json = jsonDecode(response.body);
            return Task.listFromJson(json);
          } else {
            return [];
          }
        } else {
          throw Exception("Nenhuma tarefa cadastrada.");
        }
      } else {
        throw Exception("Problemas ao consultar a tarefa.");
      }
    } catch (err) {
      throw Exception("Problemas ao consultar a tarefa. $err");
    }
  }

  /*Future<Response> insert(Task task) async {
    try {
      String json = jsonEncode(task.toJson());
      Response response = await taskRepository.insert(json);
      return response;
    } catch (err) {
      throw Exception("Problemas ao inserir a tarefa: $err");
    }
  }*/

  Future<bool> insert(Task task) async {
    try {
      String json = jsonEncode(task.toJson());
      Response response = await taskRepository.insert(json);

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception("Erro ao inserir a tarefa: ${response.statusCode}");
      }
    } catch (err) {
      throw Exception("Problemas ao inserir a tarefa: $err");
    }
  }

  Future<bool> delete(String id) async {
    try {
      Response response = await taskRepository.delete(id);

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception("Erro ao excluir a tarefa: ${response.statusCode}");
      }
    } catch (err) {
      throw Exception("Problemas ao excluir a tarefa: $err");
    }
  }

  Future<bool> update(String id, Task task) async {
    try {
      String json = jsonEncode(task.toJson());
      Response response = await taskRepository.update(id, json);

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception("Erro ao atualizar a tarefa: ${response.statusCode}");
      }
    } catch (err) {
      throw Exception("Problemas ao atualizar a tarefa: $err");
    }
  }
}
