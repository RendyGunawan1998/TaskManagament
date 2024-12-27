import '../../../core.dart';

@JsonSerializable()
class TaskModel {
  final int? id;
  final String title;
  final String description;
  final String dueDate;
  final String status;

  TaskModel({
    this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.status,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        dueDate: json["dueDate"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "dueDate": dueDate,
        "status": status,
      };

  // Task toEntity() => Task(
  //       id: id,
  //       title: title,
  //       description: description,
  //       dueDate: dueDate,
  //       status: status,
  //     );

  // factory TaskModel.fromEntity(Task task) => TaskModel(
  //       id: task.id,
  //       title: task.title,
  //       description: task.description,
  //       dueDate: task.dueDate,
  //       status: task.status,
  //     );
}
