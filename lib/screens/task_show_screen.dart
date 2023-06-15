import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/task.dart';
import '../routes/route_paths.dart';

class TaskShowScreen extends StatelessWidget {
  const TaskShowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Task task = ModalRoute.of(context)?.settings.arguments as Task;

    return Scaffold(
      appBar: AppBar(
        title: Text('$task.name'),
      ),
      body: ListView(
        padding: EdgeInsets.all(20.0),
        children: [
          TextFormField(
            initialValue: task.name,
            readOnly: true,
            style: TextStyle(fontSize: 30.0),
            decoration: InputDecoration(
              labelText: 'name',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20.0),
          TextFormField(
            initialValue: DateFormat('dd/MM/yyyy HH:mm').format(task.datetime),
            readOnly: true,
            style: TextStyle(fontSize: 20.0),
            decoration: InputDecoration(
              labelText: 'Data e Hora',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16.0),
          TextField(
            readOnly: true,
            maxLines: null,
            controller: TextEditingController(text: task.location),
            style: TextStyle(fontSize: 30.0),
            decoration: InputDecoration(
              labelText: 'Localização',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}
