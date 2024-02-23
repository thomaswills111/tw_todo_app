import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:week_4/configs/themes.dart';
import 'package:week_4/notifiers/todos_notifier.dart';
import 'package:week_4/pages/home_page.dart';
import 'package:week_4/services/data_source.dart';
import 'package:week_4/services/sql_data_source.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  GetIt.I.registerSingleton<IDataSource>(
    SQLDatasource(),
    signalsReady: true,
  );
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
