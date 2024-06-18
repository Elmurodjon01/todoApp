import 'package:go_router/go_router.dart';
import 'package:todoapp/data/model/todo_model/todo_model.dart';
import 'package:todoapp/presentation/UI/create_todo/create_todo_screen.dart';
import 'package:todoapp/presentation/UI/detail_page/detail_page.dart';
import 'package:todoapp/presentation/UI/home_screen/home_screen.dart';
import 'package:todoapp/presentation/UI/landing_screen/landing_screen.dart';

enum RouteNames {
  createTodo,
  home,
  landingPage,
  detailPage,
}

late String userId;

final goRouter = GoRouter(
  initialLocation: userId.isEmpty == true ? '/' : '/home',
  routes: [
    GoRoute(
      path: '/',
      name: RouteNames.landingPage.name,
      builder: (context, state) => const LandingScreen(),
    ),
    GoRoute(
      path: '/home',
      name: RouteNames.home.name,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/createTodo',
      name: RouteNames.createTodo.name,
      builder: (context, state) {
        if (state.extra != null) {
          TodoModel todo = state.extra as TodoModel;
          return CreateTodoScreen(
            todo: todo,
          );
        } else {
          return const CreateTodoScreen();
        }
      },
    ),
    GoRoute(
      path: '/detailPage',
      name: RouteNames.detailPage.name,
      builder: (context, state) {
        TodoModel todo = state.extra as TodoModel;
        return DetailPage(
          todo,
        );
      },
    ),
  ],
);
