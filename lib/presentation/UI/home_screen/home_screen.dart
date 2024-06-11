import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todoapp/bloc/auth_bloc/auth_bloc.dart';
import 'package:todoapp/bloc/auth_bloc/auth_event.dart';
import 'package:todoapp/bloc/cubit/toggle_cubit.dart';
import 'package:todoapp/bloc/todo_bloc/bloc/todo_bloc.dart';
import 'package:todoapp/presentation/UI/create_todo/create_todo_screen.dart';
import 'package:todoapp/presentation/UI/home_screen/custom_box.dart';
import 'package:todoapp/presentation/UI/home_screen/todo_tile.dart';
import 'package:todoapp/presentation/UI/landing_screen/landing_screen.dart';
import 'package:todoapp/presentation/widgets/custom_background.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String newValue = '';
    context.read<TodoBloc>().add(TodoLoad());
    final userId =
        Supabase.instance.client.auth.currentSession?.user.id ?? 'null';
    print('user id in home screen ->>>>>>$userId');
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          CustomBackground(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(40),
                  const SizedBox(
                    height: 45,
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
                  const Gap(25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomBox(
                        height: height,
                        width: width,
                        backColor: const Color(0xFFB4C4FF),
                        imgUrl: 'assets/icons/speakericon.svg',
                        title: 'Daily Task',
                        count: 2,
                      ),
                      CustomBox(
                        height: height,
                        width: width,
                        backColor: const Color(0xFFCFF3E9),
                        imgUrl: 'assets/icons/caricon.svg',
                        title: 'Work',
                        count: 3,
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
                        title: 'Daily Task',
                        count: 11,
                      ),
                      CustomBox(
                        height: height,
                        width: width,
                        backColor: const Color(0xFFEDBE7D),
                        imgUrl: 'assets/icons/bagIcon.svg',
                        title: 'Daily Task',
                        count: 12,
                      ),
                    ],
                  ),
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
                  const Gap(10),
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
                            itemBuilder: (context, index) {
                              final todo = state.todos[index];
                              return BlocBuilder<ToggleCubit, bool>(
                                builder: (context, state) {
                                  return TodoTile(
                                    onEdit: () {},
                                    onChoose: (value) {
                                      context
                                          .read<ToggleCubit>()
                                          .triggerToggle(value!);
                                    },
                                    onDelete: () {},
                                    todo: todo.title,
                                    dateTime:
                                        '${todo.start_time}AM to ${todo.end_time}PM',
                                    priviousTodoStatus: state,
                                    // newTodoStatus: state,
                                  );
                                },
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
            imgAdress: 'assets/images/homeback.png',
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: InkWell(
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => CreateTodoScreen())),
              child: Container(
                margin: const EdgeInsets.all(20),
                height: 58,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFF9747FF),
                  borderRadius: BorderRadius.all(
                    Radius.circular(9.5),
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Create new task',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
