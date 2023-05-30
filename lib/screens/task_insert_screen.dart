import 'package:flutter/material.dart';
import 'package:listatarefas/models/task.dart';
import 'package:location/location.dart';

class TaskInsertScreen extends StatefulWidget {
  const TaskInsertScreen({super.key});

  @override
  State<TaskInsertScreen> createState() => _TaskInsertScreenState();
}

class _TaskInsertScreenState extends State<TaskInsertScreen> {
  final _name = TextEditingController();
  final _date = TextEditingController();
  final _location = TextEditingController();

  @override
  void initState() {
    super.initState();
    getLocation().then((location) {
      setState(() {
        _location.text = location;
      });
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
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _name,
              decoration: const InputDecoration(labelText: "Nome"),
            ),
            TextField(
              controller: _date,
              keyboardType: TextInputType.datetime,
              decoration: const InputDecoration(labelText: "Data"),
            ),
            TextField(
              controller: _location,
              decoration: const InputDecoration(labelText: "Localização"),
            ),
            ElevatedButton(
              onPressed: () {
                Task task = Task(
                  _name.text,
                  _date.text,
                  _location.text,
                );
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
