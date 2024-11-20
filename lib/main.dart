import 'package:flutter/material.dart';
import 'package:univa_task/app/core/di/service_locator.dart';
import 'package:univa_task/ui/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setUpServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
