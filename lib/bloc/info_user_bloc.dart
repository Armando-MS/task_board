import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/info_user.dart';
import '../models/info_task.dart';
import '../services/info_user_service.dart';
import 'info_user_event.dart';
import 'info_user_state.dart';

class InfoUserBloc extends Bloc<InfoUserEvent, InfoUserState> {
  final InfoUserService _userService = InfoUserService();

  InfoUserBloc()
      : super(
          InfoUserState(
            user: InfoUser(name: 'Usuario', tasks: []),
          ),
        ) {
    _loadUser();

    on<UpdateUserName>(_onUpdateUserName);
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
    on<ToggleTaskStatus>(_onToggleTaskStatus);
    on<SelectTask>(_onSelectTask);
    on<ChangeTaskFilter>(_onChangeTaskFilter);
  }

  Future<void> _loadUser() async {
    final user = await _userService.loadUser();
    if (user != null) {
      emit(state.copyWith(user: user));
    }
  }

  void _onUpdateUserName(
    UpdateUserName event,
    Emitter<InfoUserState> emit,
  ) {
    final updatedUser = InfoUser(
      name: event.name,
      tasks: state.user.tasks,
    );

    emit(state.copyWith(user: updatedUser));
    _userService.saveUser(updatedUser);
  }

  void _onAddTask(AddTask event, Emitter<InfoUserState> emit) {
    final updatedTasks = List<InfoTask>.from(state.user.tasks)
      ..add(event.task);

    final updatedUser = InfoUser(
      name: state.user.name,
      tasks: updatedTasks,
    );

    emit(state.copyWith(user: updatedUser));
    _userService.saveUser(updatedUser);
  }

  void _onUpdateTask(UpdateTask event, Emitter<InfoUserState> emit) {
    final updatedTasks = state.user.tasks.map((task) {
      return task.id == event.task.id ? event.task : task;
    }).toList();

    final updatedUser = InfoUser(
      name: state.user.name,
      tasks: updatedTasks,
    );

    emit(state.copyWith(user: updatedUser));
    _userService.saveUser(updatedUser);
  }

  void _onDeleteTask(DeleteTask event, Emitter<InfoUserState> emit) {
    final updatedTasks = state.user.tasks
        .where((task) => task.id != event.taskId)
        .toList();

    final updatedUser = InfoUser(
      name: state.user.name,
      tasks: updatedTasks,
    );

    emit(state.copyWith(user: updatedUser));
    _userService.saveUser(updatedUser);
  }

  void _onToggleTaskStatus(
    ToggleTaskStatus event,
    Emitter<InfoUserState> emit,
  ) {
    final updatedTasks = state.user.tasks.map((task) {
      if (task.id == event.taskId) {
        return InfoTask(
          id: task.id,
          title: task.title,
          description: task.description,
          isCompleted: !task.isCompleted,
        );
      }
      return task;
    }).toList();

    final updatedUser = InfoUser(
      name: state.user.name,
      tasks: updatedTasks,
    );

    emit(state.copyWith(user: updatedUser));
    _userService.saveUser(updatedUser);
  }

  void _onSelectTask(SelectTask event, Emitter<InfoUserState> emit) {
    emit(state.copyWith(selectedTask: event.task));
  }

  void _onChangeTaskFilter(
    ChangeTaskFilter event,
    Emitter<InfoUserState> emit,
  ) {
    emit(state.copyWith(filter: event.filter));
  }
}
