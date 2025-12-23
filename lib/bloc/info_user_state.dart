import '../models/info_user.dart';
import '../models/info_task.dart';

enum TaskFilter {
  all,
  pending,
  completed,
}

class InfoUserState {
  final InfoUser user;
  final InfoTask? selectedTask;
  final TaskFilter filter;

  InfoUserState({
    required this.user,
    this.selectedTask,
    this.filter = TaskFilter.all,
  });

  InfoUserState copyWith({
    InfoUser? user,
    InfoTask? selectedTask,
    TaskFilter? filter,
  }) {
    return InfoUserState(
      user: user ?? this.user,
      selectedTask: selectedTask ?? this.selectedTask,
      filter: filter ?? this.filter,
    );
  }
}
