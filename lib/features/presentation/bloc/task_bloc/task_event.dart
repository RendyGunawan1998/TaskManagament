import '../../../../core.dart';

abstract class TaskEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadTasks extends TaskEvent {}

class AddTask extends TaskEvent {
  final TaskModel task;

  AddTask({required this.task});

  @override
  List<Object?> get props => [task];
}

class UpdateTask extends TaskEvent {
  final TaskModel task;

  UpdateTask({required this.task});

  @override
  List<Object?> get props => [task];
}

class DeleteTask extends TaskEvent {
  final int id;

  DeleteTask({required this.id});

  @override
  List<Object?> get props => [id];
}

class SearchTasks extends TaskEvent {
  final String query;

  SearchTasks({required this.query});

  @override
  List<Object?> get props => [query];
}
