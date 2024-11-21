import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:univa_task/app/core/di/service_locator.dart';
import 'package:univa_task/data/model/task_model.dart';
import 'package:univa_task/ui/auth/auth_page.dart';
import 'package:univa_task/utils/constants/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox(Constants.taskBox);

  await setUpServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AuthPage(),
    );
  }
}
