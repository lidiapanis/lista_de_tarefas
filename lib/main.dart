import 'package:flutter/material.dart';
import 'package:listatarefas/screens/task_edit_screen.dart';
import 'package:listatarefas/screens/task_insert_screen.dart';
import 'package:listatarefas/screens/task_list_screen.dart';
import 'package:listatarefas/screens/task_show_screen.dart';
import 'routes/route_paths.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(routes: {
      RoutePaths.HOME: (context) => const TaskListScreen(),
      RoutePaths.TASKSHOWSCREEN: (context) => const TaskShowScreen(),
      RoutePaths.TASKINSERTSCREEN: (context) => const TaskInsertScreen(),
      //RoutePaths.TASKEDITSCREEN: (context) => const TaskEditScreen(),
    });
  }
}
