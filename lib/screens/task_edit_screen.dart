import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import '../models/task.dart';
import '../services/task_service.dart';

class TaskEditScreen extends StatefulWidget {
  const TaskEditScreen({super.key});

  @override
  State<TaskEditScreen> createState() => _TaskEditScreenState();
}

class _TaskEditScreenState extends State<TaskEditScreen> {
  final _name = TextEditingController();
  DateTime _datetime = DateTime.now();
  final _location = TextEditingController();

  final taskService = TaskService();

  @override
  void initState() {
    super.initState();
    getLocation().then((location) {
      _location.text = location;
    });
  }

  @override
  void dispose() {
    _name.dispose();
    _location.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Task task = ModalRoute.of(context)?.settings.arguments as Task;

    if (task != null) {
      _name.text = task.name;
      _datetime = task.datetime;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edite a tarefa"),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            TextField(
              controller: _name,
              decoration: const InputDecoration(
                labelText: "Nome",
              ),
            ),
            TextButton(
              onPressed: () {
                showDateTimePicker();
              },
              child: Text(
                _datetime != null
                    ? DateFormat('dd/MM/yyyy HH:mm').format(_datetime)
                    : 'Data e Hora',
                style: TextStyle(color: Color.fromARGB(255, 243, 33, 33)),
              ),
            ),
            TextField(
              readOnly: true,
              maxLines: null,
              controller: TextEditingController(text: task.location),
              style: TextStyle(fontSize: 20.0),
              decoration: InputDecoration(
                labelText: 'Localização',
                border: OutlineInputBorder(),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                task.name = _name.text;
                task.datetime = _datetime;
                task.location = _location.text;
                taskService.update(task.id.toString(), task).then((_) {
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

  Future<void> showDateTimePicker() async {
    final pickedDateTime = await showDatePicker(
      context: context,
      initialDate: _datetime != null ? _datetime : DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDateTime != null) {
      final pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(
          _datetime != null ? _datetime : DateTime.now(),
        ),
      );

      if (pickedTime != null) {
        _datetime = DateTime(
          pickedDateTime.year,
          pickedDateTime.month,
          pickedDateTime.day,
          pickedTime.hour,
          pickedTime.minute,
        );
      }
    }
  }
}
