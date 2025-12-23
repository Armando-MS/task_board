import 'package:hive/hive.dart';

part 'info_task.g.dart';

@HiveType(typeId: 0)
class InfoTask extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  bool isCompleted;

  InfoTask({
    required this.id,
    required this.title,
    this.description = '',
    this.isCompleted = false,
  });
}
