import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todoapp/bloc/authentication/auth_bloc.dart';
import 'package:todoapp/bloc/toggle/toggle_cubit.dart';
import 'package:todoapp/bloc/todo_crud/bloc/todo_bloc.dart';
import 'package:todoapp/bloc/user_info/bloc/user_info_bloc.dart';
import 'package:todoapp/data/remote/userinfo_provider.dart';
import 'package:todoapp/repository/auth/auth_repo.dart';
import 'package:todoapp/repository/todo_crud/todo_repo.dart';
import 'package:todoapp/presentation/Theme/Apptheme_provider.dart';
import 'package:todoapp/repository/user_info/userinfo_repo.dart';
import 'package:todoapp/res/constants/apis.dart';
import 'package:todoapp/routes/go_router.dart';
import 'data/remote/auth_provider.dart';
import 'data/remote/todo_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: url,
    anonKey: anonKey,
  );
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (BuildContext context) => ThemeProvider()),
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

  @override
  void initState() {
    userId = Supabase.instance.client.auth.currentSession?.accessToken ?? '';
    print('user is ->>>>>> $userId');
    final user = Supabase.instance.client.auth.currentUser?.aud ?? '';
    print('user token 2 ->>>>>> $user');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepo(AuthProvider()),
        ),
        RepositoryProvider(
          create: (context) => TodoRepository(TodoProvider()),
        ),
        RepositoryProvider(
          create: (context) => UserInfoRepo(UserInfoProvider()),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              context.read<AuthRepo>(),
            ),
          ),
          BlocProvider(
            create: (context) => TodoBloc(
              context.read<TodoRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => ToggleCubit(),
          ),
          BlocProvider(
            create: (context) => UserInfoBloc(
              context.read<UserInfoRepo>(),
            ),
          ),
        ],
        child: MaterialApp.router(
          theme: themeProvider.currentTheme,
          debugShowCheckedModeBanner: false,
          routerConfig: goRouter,
          // initialRoute: userId.isEmpty == true ? '/' : '/home',
          // routes: {
          //   '/': (context) => const LandingScreen(),
          //   '/home': (context) => const HomeScreen(),
          //   // '/addScreen': (context) => const AddScreen(),
          // },
        ),
      ),
    );
  }
}
