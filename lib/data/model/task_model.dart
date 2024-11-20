class Task {
  late int id;
  late String title;
 late bool completed;

  Task({required this.id, required this.title, required this.completed});

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    completed = json['completed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['title'] = title;
    data['completed'] = completed;
    return data;
  }
}