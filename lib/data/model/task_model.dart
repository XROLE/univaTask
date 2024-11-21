import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0) // Ensure typeId is unique
class Task {
  @HiveField(0)
  int id;

  @HiveField(1)
  String title;

  @HiveField(2)
  bool completed;

  Task({required this.id, required this.title, required this.completed});

  // JSON serialization methods for other uses
  Task.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        completed = json['completed'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'completed': completed,
    };
  }
}
