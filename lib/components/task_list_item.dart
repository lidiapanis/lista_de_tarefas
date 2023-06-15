import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:listatarefas/models/task.dart';
import 'package:listatarefas/providers/task_provider.dart';
import 'package:listatarefas/screens/task_insert_screen.dart';
import 'package:provider/provider.dart';
import '../routes/route_paths.dart';

class TaskListItem extends StatefulWidget {
  const TaskListItem(
    this.task, {
    Key? key,
  }) : super(key: key);

  final Task task;

  @override
  State<TaskListItem> createState() => _TaskListItemState();
}

class _TaskListItemState extends State<TaskListItem> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TasksProvider>(builder: (context, provider, _) {
      return ListTile(
        title: Text(widget.task.name),
        subtitle:
            Text(DateFormat('dd/MM/yyyy hh:mm').format(widget.task.datetime)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                icon: const Icon(Icons.delete),
                color: const Color.fromARGB(255, 249, 105, 105),
                onPressed: () {
                  provider.delete(widget.task);
                  provider.refresh();
                }),
            IconButton(
                icon: const Icon(Icons.edit),
                color: Color.fromARGB(255, 76, 0, 255),
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(RoutePaths.TASKEDITSCREEN,
                          arguments: widget.task)
                      .then((_) {
                    provider.refresh();
                  });
                })
          ],
        ),
        onTap: () {
          Navigator.of(context)
              .pushNamed(RoutePaths.TASKSHOWSCREEN, arguments: widget.task);
        },
      );
    });
  }
}
