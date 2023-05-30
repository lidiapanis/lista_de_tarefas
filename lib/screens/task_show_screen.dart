import 'package:flutter/material.dart';
import '../models/task.dart';
import '../routes/route_paths.dart';

class TaskShowScreen extends StatelessWidget {
  const TaskShowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Task task = ModalRoute.of(context)?.settings.arguments as Task;

    return Scaffold(
        appBar: AppBar(
          title: Text(task.name),
          backgroundColor: Colors.black,
        ),
        body: Column(children: [
          Text(task.location),
          Text(task.datetime),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(RoutePaths.TASKINSERTSCREEN);
            },
            child: const Text("Editar"),
          ),
        ]));
  }
}
