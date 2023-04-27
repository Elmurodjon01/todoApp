import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/UI/addScreen.dart';
import 'package:todoapp/UI/mainScreen.dart';
import 'package:todoapp/UI/splashScreen.dart';
import 'package:todoapp/hive/themeManager.dart';
import 'package:todoapp/model/note_model.dart';
import 'package:todoapp/provider/databaseProvider.dart';
import 'package:todoapp/provider/noteProvider.dart';

void main() async {
  await Hive.initFlutter();
  // await Hive.openBox('Notes');

  WidgetsFlutterBinding.ensureInitialized();
  Hive.registerAdapter(NoteModelAdapter());

  await Hive.openBox('Notes');
  // WidgetsFlutterBinding.ensureInitialized();
  // final document = await getApplicationDocumentsDirectory();

  // await Hive.initFlutter(document.path);
  // Future<Box> openHiveBox(String boxName) async {
  //   if (!kIsWeb && !Hive.isBoxOpen(boxName))
  //     Hive.init((await getApplicationDocumentsDirectory()).path);

  //   return await Hive.openBox(boxName);
  // }

  // await Hive.openBox<NoteModel>('Notes');
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (BuildContext context) => NoteProvider()),
    ChangeNotifierProvider(create: (BuildContext context) => HiveDB()),
    // ChangeNotifierProvider(create: (BuildContext context) => ThemeNotifier()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // var provider = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashFuturePage(),
        '/home': (context) => const MainScreen(),
        '/addScreen': (context) => const AddScreen(),
      },
    );
  }
}
