import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todoapp/bloc/auth_bloc/auth_bloc.dart';
import 'package:todoapp/bloc/auth_bloc/auth_event.dart';
import 'package:todoapp/bloc/cubit/toggle_cubit.dart';
import 'package:todoapp/bloc/todo_bloc/bloc/todo_bloc.dart';
import 'package:todoapp/model/todo_model/todo_model.dart';
import 'package:todoapp/presentation/UI/create_todo/create_todo_screen.dart';
import 'package:todoapp/presentation/UI/home_screen/custom_box.dart';
import 'package:todoapp/presentation/UI/home_screen/todo_tile.dart';
import 'package:todoapp/presentation/UI/landing_screen/landing_screen.dart';
import 'package:todoapp/presentation/widgets/custom_background.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    String newValue = '';
    context.read<TodoBloc>().add(TodoLoad());
    final userId =
        Supabase.instance.client.auth.currentSession?.user.id ?? 'null';
    print('user id in home screen ->>>>>>$userId');
    final userToken = Supabase.instance.client.auth.currentSession!.accessToken;
    print('userToken $userToken');
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: CustomBackground(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Expanded(
            child: SingleChildScrollView(
              controller: controller,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(40),
                  const SizedBox(
                    height: 65,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello John',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          'You have work today',
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  ),
                  const Gap(15),
                  Cards(height: height, width: width),
                  const Gap(10),
                  InkWell(
                      onTap: () {
                        context.read<AuthBloc>().add(AuthLoggedOut());
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LandingScreen()));
                      },
                      child: const Text("Today's Tasks")),
                  SizedBox(
                    width: double.infinity,
                    height: height / 2.05,
                    child: BlocBuilder<TodoBloc, TodoState>(
                      builder: (context, state) {
                        if (state is TodoLoading) {
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
                        } else if (state is TodoLoaded) {
                          return ListView.builder(
                            itemCount: state.todos.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final todo = state.todos[index];
                              return TodoTile(
                                onEdit: () {},
                                onChoose: (value) {
                                  // context
                                  //     .read<ToggleCubit>()
                                  //     .triggerToggle(value!);
                                  context.read<TodoBloc>().add(
                                      TodoMarkCompleted(
                                          todo.copyWith(is_completed: value!)));
                                },
                                onDelete: () => context
                                    .read<TodoBloc>()
                                    .add(TodoRemove(todo)),
                                todo: todo.title,
                                dateTime:
                                    '${todo.start_time}AM to ${todo.end_time}PM',
                                priviousTodoStatus: todo.is_completed,
                                // newTodoStatus: state,
                              );
                            },
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
        ),
        imgAdress: 'assets/images/homeback.png',
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: Colors.blue,
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => CreateTodoScreen())),
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
