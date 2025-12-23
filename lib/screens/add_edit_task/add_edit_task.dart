import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/info_user_bloc.dart';
import '../../bloc/info_user_event.dart';
import '../../models/info_task.dart';

class AddEditTask extends StatefulWidget {
  const AddEditTask({super.key});

  @override
  State<AddEditTask> createState() => _AddEditTaskState();
}

class _AddEditTaskState extends State<AddEditTask> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final selectedTask =
        context.read<InfoUserBloc>().state.selectedTask;

    if (selectedTask != null) {
      _titleController.text = selectedTask.title;
      _descriptionController.text = selectedTask.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedTask =
        context.watch<InfoUserBloc>().state.selectedTask;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          selectedTask == null ? 'Nueva tarea' : 'Editar tarea',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Título',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'El título es obligatorio';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Descripción',
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveTask,
                child: const Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveTask() {
    if (_formKey.currentState!.validate()) {
      final bloc = context.read<InfoUserBloc>();
      final selectedTask = bloc.state.selectedTask;

      if (selectedTask == null) {
        bloc.add(
          AddTask(
            InfoTask(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              title: _titleController.text.trim(),
              description: _descriptionController.text.trim(),
            ),
          ),
        );
      } else {
        bloc.add(
          UpdateTask(
            InfoTask(
              id: selectedTask.id,
              title: _titleController.text.trim(),
              description: _descriptionController.text.trim(),
              isCompleted: selectedTask.isCompleted,
            ),
          ),
        );
      }

      bloc.add(SelectTask(null));
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
