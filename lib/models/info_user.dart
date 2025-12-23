import 'package:hive/hive.dart';
import 'info_task.dart';

part 'info_user.g.dart';

@HiveType(typeId: 1)
class InfoUser extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final List<InfoTask> tasks;

  InfoUser({
    required this.name,
    required this.tasks,
  });
}
