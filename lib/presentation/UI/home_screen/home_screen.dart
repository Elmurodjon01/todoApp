import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todoapp/bloc/authentication/auth_bloc.dart';
import 'package:todoapp/bloc/authentication/auth_event.dart';
import 'package:todoapp/bloc/todo_crud/bloc/todo_bloc.dart';
import 'package:todoapp/bloc/user_info/bloc/user_info_bloc.dart';
import 'package:todoapp/data/model/todo_model/todo_model.dart';
import 'package:todoapp/data/model/user/user_info_model.dart';
import 'package:todoapp/presentation/UI/home_screen/custom_box.dart';
import 'package:todoapp/presentation/UI/home_screen/todo_tile.dart';
import 'package:todoapp/presentation/UI/landing_screen/landing_screen.dart';
import 'package:todoapp/presentation/widgets/custom_background.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/routes/go_router.dart';
part 'flag.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<TodoBloc>().add(TodoLoad());
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
                            return Text(
                              'Hello ${userInfo.username}',
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            );
                          } else {
                            return const CircularProgressIndicator.adaptive();
                          }
                        },
                      ),
                      const Text(
                        'You have work today',
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                ),
                Cards(height: height, width: width),
                const Gap(10),
                InkWell(
                  onTap: () {
                    context.read<AuthBloc>().add(AuthLoggedOut());
                    context.pushNamed(RouteNames.landingPage.name);
                  },
                  child: const Text(
                    "Today's Tasks",
                  ),
                ),
                SizedBox(
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
                                    // context
                                    //     .read<ToggleCubit>()
                                    //     .triggerToggle(value!);
                                    context.read<TodoBloc>().add(
                                        TodoMarkCompleted(todo.copyWith(
                                            is_completed: value!)));
                                  },
                                  onDelete: () => context
                                      .read<TodoBloc>()
                                      .add(TodoRemove(todo)),
                                  todo: todo.title,
                                  dateTime:
                                      '${todo.start_time}AM to ${todo.end_time}PM',
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
                              Image.asset(
                                'assets/icons/no_todos.png',
                                height: 222,
                                width: 222,
                              ),
                              const Text('There is no todos for today'),
                            ],
                          ),
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
        backgroundColor: Colors.blue,
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

class Cards extends StatelessWidget {
  const Cards({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(builder: (context, state) {
      if (state is TodoLoading) {
        return const CircularProgressIndicator.adaptive();
      } else if (state is TodoFailure) {
        return Text(state.error);
      } else if (state is TodoLoaded) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomBox(
                  height: height,
                  width: width,
                  backColor: const Color(0xFFB4C4FF),
                  imgUrl: 'assets/icons/speakericon.svg',
                  title: 'Daily Task',
                  count: todoCount(state.todos, 'dailytask'),
                ),
                CustomBox(
                  height: height,
                  width: width,
                  backColor: const Color(0xFFCFF3E9),
                  imgUrl: 'assets/icons/caricon.svg',
                  title: 'Work',
                  count: todoCount(state.todos, 'work'),
                ),
              ],
            ),
            const Gap(8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomBox(
                  height: height,
                  width: width,
                  backColor: const Color(0xFF9747FF),
                  imgUrl: 'assets/icons/gymicon.svg',
                  title: 'Projects',
                  count: todoCount(state.todos, 'project'),
                ),
                CustomBox(
                  height: height,
                  width: width,
                  backColor: const Color(0xFFEDBE7D),
                  imgUrl: 'assets/icons/bagIcon.svg',
                  title: 'Groceries',
                  count: todoCount(state.todos, "groceries"),
                ),
              ],
            ),
          ],
        );
      }
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomBox(
                height: height,
                width: width,
                backColor: const Color(0xFFB4C4FF),
                imgUrl: 'assets/icons/speakericon.svg',
                title: 'Daily Task',
                count: 0,
              ),
              CustomBox(
                height: height,
                width: width,
                backColor: const Color(0xFFCFF3E9),
                imgUrl: 'assets/icons/caricon.svg',
                title: 'Work',
                count: 0,
              ),
            ],
          ),
          const Gap(8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomBox(
                height: height,
                width: width,
                backColor: const Color(0xFF9747FF),
                imgUrl: 'assets/icons/gymicon.svg',
                title: 'Projects',
                count: 0,
              ),
              CustomBox(
                height: height,
                width: width,
                backColor: const Color(0xFFEDBE7D),
                imgUrl: 'assets/icons/bagIcon.svg',
                title: 'Groceries',
                count: 0,
              ),
            ],
          ),
        ],
      );
    });
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
