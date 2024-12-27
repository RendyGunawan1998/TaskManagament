import '../../../../core.dart';

abstract class TaskState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final List<TaskModel> tasks;

  TaskLoaded({required this.tasks});

  @override
  List<Object?> get props => [tasks];
}

class TaskError extends TaskState {
  final String message;

  TaskError({required this.message});

  @override
  List<Object?> get props => [message];
}

class TaskSuccess extends TaskState {
  final String message;

  TaskSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}
