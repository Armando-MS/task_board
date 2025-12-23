import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/info_user_bloc.dart';
import '../../bloc/info_user_event.dart';
import '../../bloc/info_user_state.dart';

class TaskFilterWidget extends StatelessWidget {
  const TaskFilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InfoUserBloc, InfoUserState>(
      buildWhen: (prev, curr) => prev.filter != curr.filter,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _FilterButton(
                label: 'Todas',
                isSelected: state.filter == TaskFilter.all,
                onTap: () {
                  context
                      .read<InfoUserBloc>()
                      .add(ChangeTaskFilter(TaskFilter.all));
                },
              ),
              _FilterButton(
                label: 'Pendientes',
                isSelected: state.filter == TaskFilter.pending,
                onTap: () {
                  context
                      .read<InfoUserBloc>()
                      .add(ChangeTaskFilter(TaskFilter.pending));
                },
              ),
              _FilterButton(
                label: 'Completadas',
                isSelected: state.filter == TaskFilter.completed,
                onTap: () {
                  context
                      .read<InfoUserBloc>()
                      .add(ChangeTaskFilter(TaskFilter.completed));
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class _FilterButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (_) => onTap(),
      ),
    );
  }
}
