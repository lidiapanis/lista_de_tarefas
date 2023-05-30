import 'package:flutter/material.dart';
import 'package:listatarefas/models/task.dart';
import 'package:listatarefas/providers/task_provider.dart';
import 'package:provider/provider.dart';
import '../routes/route_paths.dart';

class TaskListItem extends StatelessWidget {
  const TaskListItem(this.task, {super.key});

  final Task task;

  @override
  Widget build(BuildContext context) {
    final _tasks = Provider.of<TasksProvider>(context);
    return ListTile(
      leading: Icon(Icons.class_rounded),
      iconColor: const Color.fromARGB(255, 234, 234, 234),
      title: Text(task.name),
      subtitle: Text(task.datetime),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        color: const Color.fromARGB(255, 249, 105, 105),
        onPressed: () => _tasks.delete(task),
      ),
      onTap: () {
        Navigator.of(context)
            .pushNamed(RoutePaths.TASKSHOWSCREEN, arguments: task);
      },
    );
  }
}
