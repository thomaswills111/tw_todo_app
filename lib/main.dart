import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:week_4/configs/themes.dart';
import 'package:week_4/notifiers/todos_notifier.dart';
import 'package:week_4/pages/home_page.dart';
import 'package:week_4/services/data_source.dart';
import 'package:week_4/services/hive_data_source.dart';
import 'package:week_4/services/sql_data_source.dart';
import 'package:get/get.dart';

void main() async {
  // For Get (not Get it)
  WidgetsFlutterBinding.ensureInitialized();
  Get.put<IDataSource>(HiveDataSource());

  runApp(ChangeNotifierProvider(
      create: (context) => TodosNotifier(), child: const TodoApp()));
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      theme: appTheme,
      home: const HomePage(title: 'Home'),
    );
  }
}
