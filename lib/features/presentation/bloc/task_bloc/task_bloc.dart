import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskLocalDataSource taskDatabase;

  TaskBloc({required this.taskDatabase}) : super(TaskLoading()) {
    on<LoadTasks>(_onLoadTasks);
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
    on<SearchTasks>(onSearchTasks);
  }

  Future<void> _onLoadTasks(LoadTasks event, Emitter<TaskState> emit) async {
    try {
      final tasks = await taskDatabase.getAllTasks();
      emit(TaskLoaded(tasks: tasks));
    } catch (e) {
      emit(TaskError(message: 'Failed to load tasks'));
    }
  }

  Future<void> _onAddTask(AddTask event, Emitter<TaskState> emit) async {
    try {
      await taskDatabase.insertTask(event.task);
      final updatedTasks = await taskDatabase.getAllTasks();
      emit(TaskLoaded(tasks: updatedTasks));
    } catch (e) {
      print('error add :: ${e.toString()}');
      emit(TaskError(message: 'Failed to add task'));
    }
  }

  Future<void> _onUpdateTask(UpdateTask event, Emitter<TaskState> emit) async {
    if (state is TaskLoaded) {
      print('call update');
      try {
        await taskDatabase.updateTask(event.task);
        final updatedTasks = await taskDatabase.getAllTasks();
        emit(TaskLoaded(tasks: updatedTasks));
      } catch (e) {
        print('error update :: ${e.toString()}');
        emit(TaskError(message: 'Failed to update task'));
      }
    }
  }

  Future<void> _onDeleteTask(DeleteTask event, Emitter<TaskState> emit) async {
    try {
      await taskDatabase.deleteTask(event.id);
      final updatedTasks = await taskDatabase.getAllTasks();
      emit(TaskLoaded(tasks: updatedTasks));
    } catch (e) {
      emit(TaskError(message: 'Failed to delete task'));
    }
  }

  void onSearchTasks(SearchTasks event, Emitter<TaskState> emit) {
    final tasks = (state as TaskLoaded).tasks;
    final filteredTasks = tasks
        .where((task) =>
            task.title.toLowerCase().contains(event.query.toLowerCase()))
        .toList();
    emit(TaskLoaded(tasks: filteredTasks));
  }
}
