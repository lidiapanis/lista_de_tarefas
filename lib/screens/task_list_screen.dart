import 'package:flutter/material.dart';
import 'package:listatarefas/providers/task_provider.dart';
import 'package:listatarefas/routes/route_paths.dart';
import 'package:listatarefas/screens/task_insert_screen.dart';
import 'package:provider/provider.dart';
import '../components/task_list.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Minhas Tarefas"),
        backgroundColor: Colors.black,
        /*actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              Navigator.of(context).pushNamed(RoutePaths.TASKINSERTSCREEN);
            },
          ),
        ],*/
      ),
      body: ChangeNotifierProvider(
        create: (context) => TasksProvider(),
        child: Column(
          children: const [
            TaskList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(RoutePaths.TASKINSERTSCREEN);
        },
      ),
    );
  }
}
