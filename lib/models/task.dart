class Task {
  String? id;
  String name;
  DateTime datetime;
  String location;

  Task(
    this.name,
    this.datetime,
    this.location,
  );

  Task.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        datetime = DateTime.parse(json['datetime']),
        location = json['location'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'datetime': datetime.toIso8601String(),
        'location': location,
      };

  static List<Task> listFromJson(Map<String, dynamic> json) {
    try {
      List<Task> tasks = [];
      json.forEach((key, value) {
        Map<String, dynamic> item = {"id": key, ...value};
        tasks.add(Task.fromJson(item));
      });
      return tasks;
    } catch (error) {
      return []; // Retorna uma lista vazia em caso de erro na conversão
    }
  }
}
