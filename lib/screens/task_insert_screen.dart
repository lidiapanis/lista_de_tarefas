import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:listatarefas/models/task.dart';
import 'package:listatarefas/routes/route_paths.dart';
import 'package:listatarefas/services/task_service.dart';
import 'package:location/location.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/task_provider.dart';

class TaskInsertScreen extends StatefulWidget {
  const TaskInsertScreen({super.key});

  @override
  State<TaskInsertScreen> createState() => _TaskInsertScreenState();
}

final tasksService = TaskService();
final tasksProvider = TasksProvider();

class _TaskInsertScreenState extends State<TaskInsertScreen> {
  final _name = TextEditingController();
  DateTime _datetime = DateTime.now();
  final _location = TextEditingController();

  @override
  void initState() {
    super.initState();
    getLocation().then((location) {
      _location.text = location;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nova Tarefa"),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            TextField(
              controller: _name,
              decoration: const InputDecoration(labelText: "Nome"),
            ),
            TextButton(
              onPressed: () {
                DatePicker.showDateTimePicker(
                  context,
                  showTitleActions: true,
                  onConfirm: (dateTime) {
                    setState(() {
                      _datetime = dateTime;
                    });
                  },
                  currentTime: _datetime = DateTime.now(),
                );
              },
              child: Text(
                _datetime != null
                    ? DateFormat('dd/MM/yyyy hh:mm').format(_datetime)
                    : 'Selecione a Data e Hora',
                style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
              ),
            ),
            TextField(
              controller: _location,
              decoration: const InputDecoration(labelText: "Localização"),
            ),
            ElevatedButton(
              onPressed: () {
                Task task = Task(
                  _name.text,
                  _datetime,
                  _location.text,
                );
                /*tasksProvider.insert(task);
                setState(() {
                  tasksProvider.refresh();
                });
                Navigator.pop(context);*/
                tasksService.insert(task).then((_) {
                  Navigator.pop(context);
                });
              },
              child: const Text("Salvar"),
            ),
          ],
        ),
      ),
    );
  }

  Future<String> getLocation() async {
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) Future.value("null");
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) Future.value("null");
    }

    locationData = await location.getLocation();
    return "${locationData.latitude} : ${locationData.longitude}";
  }
}
