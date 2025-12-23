import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/info_user_bloc.dart';
import '../../bloc/info_user_event.dart';
import '../../bloc/info_user_state.dart';
import '../add_edit_task/add_edit_task.dart';
import '../../widgets/task_filter/task_filter_widget.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TaskBoard')),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          context.read<InfoUserBloc>().add(SelectTask(null));
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddEditTask()),
          );
        },
      ),
      body: BlocBuilder<InfoUserBloc, InfoUserState>(
        builder: (context, state) {
          final tasks = state.user.tasks.where((task) {
            switch (state.filter) {
              case TaskFilter.pending:
                return !task.isCompleted;
              case TaskFilter.completed:
                return task.isCompleted;
              case TaskFilter.all:
              default:
                return true;
            }
          }).toList();

          if (tasks.isEmpty) {
            return const Center(child: Text('No hay tareas'));
          }

          return Column(
            children: [
              const TaskFilterWidget(),
              Expanded(
                child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];

                    return Dismissible(
                      key: ValueKey(task.id),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        color: Colors.red,
                        child:
                            const Icon(Icons.delete, color: Colors.white),
                      ),
                      onDismissed: (_) {
                        context
                            .read<InfoUserBloc>()
                            .add(DeleteTask(task.id));
                      },
                      child: ListTile(
                        leading: Checkbox(
                          value: task.isCompleted,
                          onChanged: (_) {
                            context
                                .read<InfoUserBloc>()
                                .add(ToggleTaskStatus(task.id));
                          },
                        ),
                        title: Text(task.title),
                        subtitle: Text(task.description),
                        onTap: () {
                          context
                              .read<InfoUserBloc>()
                              .add(SelectTask(task));
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const AddEditTask(),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
