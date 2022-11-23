import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/UI/addScreen.dart';
import 'package:todoapp/UI/mainScreen.dart';
import 'package:todoapp/provider/noteProvider.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('Notes');
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (BuildContext context) => NoteProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MainScreen(),
        '/addScreen': (context) => AddScreen(),
      },
    );
  }
}
