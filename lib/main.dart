import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/UI/addScreen.dart';
import 'package:todoapp/UI/mainScreen.dart';
import 'package:todoapp/UI/splashScreen.dart';
import 'package:todoapp/hive/database.dart';
import 'package:todoapp/model/note_model.dart';
import 'package:todoapp/provider/Apptheme_provider.dart';

void main() async {
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();
  Hive.registerAdapter(NoteModelAdapter());

  await Hive.openBox<NoteModel>('Notes');
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (BuildContext context) => AppTheme()),
    ChangeNotifierProvider(create: (BuildContext context) => Database()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<AppTheme>(context).currentTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashFuturePage(),
        '/home': (context) => const MainScreen(),
        '/addScreen': (context) => const AddScreen(),
      },
    );
  }
}
