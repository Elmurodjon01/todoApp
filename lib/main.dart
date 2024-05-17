import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todoapp/bloc/auth_bloc/auth_bloc.dart';
import 'package:todoapp/constants/apis.dart';
import 'package:todoapp/data/provider/auth_provider.dart';
import 'package:todoapp/data/repository/auth_repo.dart';
import 'package:todoapp/presentation/UI/addScreen.dart';
import 'package:todoapp/presentation/UI/home_screen/home_screen.dart';
import 'package:todoapp/presentation/UI/landing_screen/landing_screen.dart';
import 'package:todoapp/presentation/UI/mainScreen.dart';
import 'package:todoapp/hive/database.dart';
import 'package:todoapp/model/todoModel/note_model.dart';
import 'package:todoapp/presentation/Theme/Apptheme_provider.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Supabase.initialize(
//     url: url,
//     anonKey: anonKey,
//   );
//   runApp(MaterialApp(home: HomeApp()));
// }

// class HomeApp extends StatelessWidget {
//   const HomeApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final user = UserModel(
//         email: 'elmurodjon@inha.edu',
//         password: 'password',
//         username: 'username');

//     return RepositoryProvider(
//       create: (context) => AuthRepo(AuthProvider()),
//       child: BlocProvider(
//         create: (context) {
//           print('bloc started');
//           return AuthBloc(context.read<AuthRepo>())..add(SignInEvent(user));
//         },
//         child: Scaffold(
//           appBar: AppBar(
//             backgroundColor: Colors.red,
//           ),
//           body: BlocBuilder<AuthBloc, AuthBlocState>(builder: (context, state) {
//             if (state is AuthInitial) {
//               return const Center(
//                 child: CircularProgressIndicator.adaptive(),
//               );
//             }
//             if (state is AuthFailure) {
//               return const Center(
//                 child: Text('error'),
//               );
//             }
//             if (state is AuthSignedIn) {
//               return Text(state.userToken);
//             }
//             return const Center(
//               child: CircularProgressIndicator.adaptive(),
//             );
//           }),
//           floatingActionButton: FloatingActionButton(
//             onPressed: () {},
//             child: const Icon(Icons.replay_outlined),
//           ),
//         ),
//       ),
//     );
//   }
// }

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(NoteModelAdapter());

  await Hive.openBox<NoteModel>('Notes');
  await Hive.openBox('theme');
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: url,
    anonKey: anonKey,
  );
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (BuildContext context) => ThemeProvider()),
    ChangeNotifierProvider(create: (BuildContext context) => Database()),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;
  late String userId;

  @override
  void initState() {
    userId = Supabase.instance.client.auth.currentSession?.user.id ?? '';
    print('user is ->>>>>> $userId');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return RepositoryProvider(
      create: (context) => AuthRepo(AuthProvider()),
      child: BlocProvider(
        create: (context) => AuthBloc(context.read<AuthRepo>()),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: themeProvider.currentTheme,
          initialRoute: userId.isEmpty == true ? '/' : '/home',
          routes: {
            '/': (context) => const LandingScreen(),
            '/home': (context) => const HomeScreen(),
            '/addScreen': (context) => const AddScreen(),
          },
        ),
      ),
    );
  }
}
