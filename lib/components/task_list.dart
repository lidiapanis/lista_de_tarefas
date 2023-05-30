import 'package:flutter/material.dart';
import 'package:listatarefas/components/task_list_item.dart';
import 'package:listatarefas/providers/task_provider.dart';
import 'package:listatarefas/services/task_service.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';

class TaskList extends StatelessWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context) {
    final _tasks = Provider.of<TasksProvider>(context);

    List<Widget> _generateListTasks(List<Task> tasks) {
      return tasks.map((task) => TaskListItem(task)).toList();
    }

    return FutureBuilder<List<Task>>(
      future: TaskService().getAll(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text("Erro ao consultar dados: ${snapshot.error}"),
          );
        } else if (snapshot.hasData) {
          final list = snapshot.data;
          if (list != null && list.isNotEmpty) {
            return Expanded(
              child: ListView(
                children: _generateListTasks(list),
              ),
            );
          } else {
            return const Center(
              child: Text("Nenhum produto cadastrado."),
            );
          }
        } else {
          return const Center(
            child: Text("Nenhum produto cadastrado."),
          );
        }
      },
    );
  }
}
