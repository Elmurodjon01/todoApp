import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todoapp/bloc/auth_bloc/auth_bloc.dart';
import 'package:todoapp/bloc/auth_bloc/auth_event.dart';
import 'package:todoapp/main.dart';
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
                  SizedBox(
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
                                builder: (context) => LandingScreen()));
                      },
                      child: const Text("Today's Tasks")),
                  const Gap(10),
                  SizedBox(
                    width: double.infinity,
                    height: height / 2.05,
                    child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return TodoTile(
                          onEdit: () {},
                          onChoose: (value) {},
                          onDelete: () {},
                          todo: 'Email to work',
                          dateTime: '08:00 AM to 12:00 PM',
                        );
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
