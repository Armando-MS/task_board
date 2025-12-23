import 'package:hive/hive.dart';
import '../models/info_user.dart';

class InfoUserService {
  static const String boxName = 'userBox';

  Future<void> saveUser(InfoUser user) async {
    final box = await Hive.openBox<InfoUser>(boxName);
    await box.put('user', user);
  }

  Future<InfoUser?> loadUser() async {
    final box = await Hive.openBox<InfoUser>(boxName);
    return box.get('user');
  }
}
