import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/bloc/auth_bloc/auth_bloc.dart';
import 'package:todoapp/presentation/UI/landing_screen/landing_screen.dart';
import 'package:todoapp/presentation/UI/mainScreen.dart';

class RedirectScreen extends StatefulWidget {
  const RedirectScreen({super.key});

  @override
  State<RedirectScreen> createState() => _RedirectScreenState();
}

class _RedirectScreenState extends State<RedirectScreen> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthBlocState>(
      listener: (context, state) {
        switch (state) {
          case AuthSignedIn(userToken: " state.userToken"):
            _navigator.push(MaterialPageRoute(
                builder: (context) => HomeScreen(userToken: state.userToken)));
            break;
          default:
            _navigator
                .push(MaterialPageRoute(builder: (context) => LandingScreen()));
        }
      },
    );
  }
}
