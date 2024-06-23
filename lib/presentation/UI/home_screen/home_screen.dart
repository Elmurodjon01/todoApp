import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:todoapp/bloc/authentication/auth_bloc.dart';
import 'package:todoapp/bloc/authentication/auth_event.dart';
import 'package:todoapp/bloc/todo_crud/bloc/todo_bloc.dart';
import 'package:todoapp/bloc/user_info/bloc/user_info_bloc.dart';
import 'package:todoapp/data/model/todo_model/todo_model.dart';
import 'package:todoapp/presentation/UI/home_screen/custom_box.dart';
import 'package:todoapp/presentation/UI/home_screen/todo_tile.dart';
import 'package:todoapp/presentation/helper/hour_formatter.dart';
import 'package:todoapp/presentation/widgets/custom_background.dart';
import 'package:todoapp/routes/go_router.dart';
import 'package:intl/intl.dart';
part 'flag.dart';
part 'todo_cards.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<TodoBloc>().add(TodoLoad());
    context.read<UserInfoBloc>().add(LoadUserInfo());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: CustomBackground(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(50),
                SizedBox(
                  height: 65,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlocBuilder<UserInfoBloc, UserInfoState>(
                        builder: (context, state) {
                          if (state is UserInfoLoadError) {
                            return Text(state.error);
                          } else if (state is UserInfoLoadedState) {
                            final userInfo = state.userInfo;
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Hello ${userInfo.username}',
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                                IconButton(
                                  onPressed: () {
                                    context
                                        .read<AuthBloc>()
                                        .add(AuthLoggedOut());
                                    context
                                        .pushNamed(RouteNames.landingPage.name);
                                  },
                                  icon: const Icon(Icons.logout),
                                ),
                              ],
                            );
                          } else {
                            return const CircularProgressIndicator.adaptive();
                          }
                        },
                      ),
                      BlocBuilder<TodoBloc, TodoState>(
                        builder: (context, state) {
                          if (state is TodoEmpty) {
                            return const Text(
                              'You have no work today',
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.w300),
                            );
                          }
                          return const Text(
                            'You have work today',
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.w300),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Cards(height: height, width: width),
                const Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Today's Tasks",
                    ),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () =>
                              context.read<TodoBloc>().add(TodoLoad()),
                          child: const Text(
                            'All',
                            style: TextStyle(
                              color: Color(0xFF9747FF),
                              decoration: TextDecoration.underline,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            final response = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2010),
                              lastDate: DateTime(2050),
                            );
                            if (response != null) {
                              String formattedFlutterDate =
                                  DateFormat('yyyy-MM-dd').format(response);
                              context
                                  .read<TodoBloc>()
                                  .add(TodoFilter(formattedFlutterDate));
                            }
                          },
                          icon: const Icon(
                            Icons.calendar_month,
                            color: Color(0xFF9747FF),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 45),
                  width: double.infinity,
                  height: height / 1.8,
                  child: BlocBuilder<TodoBloc, TodoState>(
                    builder: (context, state) {
                      if (state is TodoLoaded) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.todos.length,
                          itemBuilder: (context, index) {
                            final todo = state.todos[index];
                            return Stack(
                              children: [
                                TodoTile(
                                  onTap: () => context.pushNamed(
                                      RouteNames.detailPage.name,
                                      extra: todo),
                                  onEdit: () => context.pushNamed(
                                      RouteNames.createTodo.name,
                                      extra: todo),
                                  onChoose: (value) {
                                    context.read<TodoBloc>().add(
                                        TodoMarkCompleted(todo.copyWith(
                                            is_completed: value!)));
                                  },
                                  onDelete: () => context
                                      .read<TodoBloc>()
                                      .add(TodoRemove(state.todos, todo)),
                                  todo: todo.title,
                                  dateTime:
                                      '${formatTime(stringToTimeOfDay(todo.start_time))} to ${formatTime(stringToTimeOfDay(todo.end_time))}',
                                  priviousTodoStatus: todo.is_completed,
                                  // newTodoStatus: state,
                                ),
                                Positioned(
                                  top: 5,
                                  right: 15,
                                  child: Flag(
                                    label: todo.priority,
                                    imgAddress: imgType(todo.priority),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      } else if (state is TodoLoading) {
                        return const Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                      } else if (state is TodoFailure) {
                        return Center(
                          child: Text(state.error),
                        );
                      } else if (state is TodoInitial) {
                        return const Center(
                          child: Text('Loading...'),
                        );
                      } else if (state is TodoEmpty) {
                        return Center(
                          child: Column(
                            children: [
                              const Gap(70),
                              Lottie.asset(
                                'assets/images/empty.json',
                                height: 222,
                                width: 222,
                              ),
                              const Text('Empty!'),
                            ],
                          ),
                        );
                      } else if (state is TodoFiltered) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.filteredTodos.length,
                          itemBuilder: (context, index) {
                            final todo = state.filteredTodos[index];
                            return Stack(
                              children: [
                                TodoTile(
                                  onTap: () => context.pushNamed(
                                      RouteNames.detailPage.name,
                                      extra: todo),
                                  onEdit: () => context.pushNamed(
                                      RouteNames.createTodo.name,
                                      extra: todo),
                                  onChoose: (value) {
                                    context.read<TodoBloc>().add(
                                        TodoMarkCompleted(todo.copyWith(
                                            is_completed: value!)));
                                  },
                                  onDelete: () => context.read<TodoBloc>().add(
                                      TodoRemove(state.filteredTodos, todo)),
                                  todo: todo.title,
                                  dateTime:
                                      '${formatTime(stringToTimeOfDay(todo.start_time))} to ${formatTime(stringToTimeOfDay(todo.end_time))}',
                                  priviousTodoStatus: todo.is_completed,
                                  // newTodoStatus: state,
                                ),
                                Positioned(
                                  top: 5,
                                  right: 15,
                                  child: Flag(
                                    label: todo.priority,
                                    imgAddress: imgType(todo.priority),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      }
                      return const Text('Something went wrong');
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        imgAdress: 'assets/images/homeback.png',
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: const Color(0xFF9747FF),
        onPressed: () => context.pushNamed(RouteNames.createTodo.name),
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}

int todoCount(List<TodoModel> todos, String category) {
  int count = 0;
  for (TodoModel todo in todos) {
    if (todo.category == category) {
      count++;
    }
  }
  return count;
}
