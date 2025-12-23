import '../models/info_task.dart';
import 'info_user_state.dart';

abstract class InfoUserEvent {}

class UpdateUserName extends InfoUserEvent {
  final String name;
  UpdateUserName(this.name);
}

class AddTask extends InfoUserEvent {
  final InfoTask task;
  AddTask(this.task);
}

class UpdateTask extends InfoUserEvent {
  final InfoTask task;
  UpdateTask(this.task);
}

class DeleteTask extends InfoUserEvent {
  final String taskId;
  DeleteTask(this.taskId);
}

class ToggleTaskStatus extends InfoUserEvent {
  final String taskId;
  ToggleTaskStatus(this.taskId);
}

class SelectTask extends InfoUserEvent {
  final InfoTask? task;
  SelectTask(this.task);
}

class ChangeTaskFilter extends InfoUserEvent {
  final TaskFilter filter;
  ChangeTaskFilter(this.filter);
}
