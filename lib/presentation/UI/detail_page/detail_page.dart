import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/data/model/todo_model/todo_model.dart';
import 'package:todoapp/presentation/UI/home_screen/home_screen.dart';
import 'package:todoapp/presentation/helper/hour_formatter.dart';
import 'package:todoapp/presentation/widgets/custom_background.dart';

class DetailPage extends StatelessWidget {
  DetailPage(this.todo, {super.key});
  final TodoModel? todo;

  List<Color> colors = [
    const Color(0xFF9747FF),
    Colors.blue,
    Colors.grey,
  ];
  List<String> allDates = [];
  void addAllDates(String date1, date2, date3) {
    allDates.addAll([date1, formatTime(stringToTimeOfDay(date2)), formatTime(stringToTimeOfDay(date3))]);
  }

  final DateFormat dateFormatter = DateFormat('yyyy-MM-dd');
  @override
  Widget build(BuildContext context) {
    addAllDates(dateFormatter.format(DateTime.parse(todo!.created_at)),
        todo!.start_time, todo!.end_time);
    return Scaffold(
      body: CustomBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(50),
                Row(
                  children: [
                    IconButton(
                      onPressed: () => context.pop(),
                      icon: const Icon(Icons.arrow_back_ios),
                    ),
                  ],
                ),
                const Gap(15),
                Row(
                  children: [
                    Text(
                      todo!.title,
                      style: const TextStyle(
                          fontSize: 32, fontWeight: FontWeight.w600),
                    ),
                    Flag(
                        label: todo!.priority,
                        imgAddress: imgType(todo!.priority))
                  ],
                ),
                const Gap(10),
                Text(
                  todo!.description,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w400),
                ),
                const Gap(15),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(right: 10),
                        height: 50,
                        width: 130,
                        decoration: BoxDecoration(
                          color: colors[index],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            allDates[index],
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const Gap(20),
              ],
            ),
          ),
        ),
        imgAdress: 'assets/images/createTodoBack.png',
      ),
    );
  }
}
