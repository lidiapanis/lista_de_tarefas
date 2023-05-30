class Task {
  String? id;
  String name;
  String datetime;
  String location;

  Task(
    this.name,
    this.datetime,
    this.location,
  );

  Task.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        datetime = json['datetime'],
        location = json['location'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'datetime': datetime,
        'location': location,
      };

  static List<Task> listFromJson(Map<String, dynamic> json) {
    List<Task> tasks = [];
    json.forEach((key, value) {
      Map<String, dynamic> item = {"id": key, ...value};
      tasks.add(Task.fromJson(item));
    });
    return tasks;
  }
}
