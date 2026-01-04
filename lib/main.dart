import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'bloc/info_user_bloc.dart';
import 'models/info_task.dart';
import 'models/info_user.dart';
import 'screens/main_screen/main_screen.dart';
import 'package:task_board/screens/products/product_screen.dart';
import 'package:task_board/screens/user_screen/user_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(InfoTaskAdapter());
  Hive.registerAdapter(InfoUserAdapter());

  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => InfoUserBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'API',
        home: const UserScreen(),
      ),
    );
  }
}
