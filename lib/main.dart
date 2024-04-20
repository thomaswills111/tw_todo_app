import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week_4/configs/themes.dart';
import 'package:week_4/firebase_options.dart';
import 'package:week_4/notifiers/todos_notifier.dart';
import 'package:week_4/pages/home_page.dart';
import 'package:week_4/services/data_source.dart';
import 'package:week_4/services/remote_api_datasource.dart';
import 'package:get/get.dart';

void main() async {
  // For Get (not Get it)
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Get.put<IDataSource>(RemoteApiDatasource());

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
