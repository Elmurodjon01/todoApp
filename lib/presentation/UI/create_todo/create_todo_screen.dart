import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:todoapp/presentation/widgets/custom_background.dart';

class CreateTodoScreen extends StatefulWidget {
  CreateTodoScreen({super.key});

  @override
  State<CreateTodoScreen> createState() => _CreateTodoScreenState();
}

class _CreateTodoScreenState extends State<CreateTodoScreen> {
  final options = [
    "Education",
    "Work",
    "Groceries",
  ];
  late bool value;
  TextEditingController taskController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();

  final priorities = [
    "Low",
    "Medium",
    "High",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(30),
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_sharp),
                    ),
                    const Gap(70),
                    const Text('Create a new task'),
                  ],
                ),
                const Gap(25),
                const Text(
                  'Task Name',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                const Gap(7),
                CustomTextField(
                  taskController,
                  null,
                  null,
                  double.infinity,
                  40,
                ),
                const Gap(15),
                const Text(
                  'Category',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                const Gap(7),
                Wrap(
                  children: List.generate(
                    options.length,
                    (int index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: ChoiceChip(
                          labelStyle: const TextStyle(fontSize: 12),
                          label: Text(
                            options[index],
                          ),
                          selected: true,
                          onSelected: (value) {},
                        ),
                      );
                    },
                  ).toList(),
                ),
                const Gap(15),
                const Text(
                  'Date & Time',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                const Gap(7),
                CustomTextField(
                  taskController,
                  '09 November, Wednesday',
                  SvgPicture.asset(
                    'assets/icons/calendar.svg',
                  ),
                  double.infinity,
                  40,
                ),
                const Gap(15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Start time',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const Gap(7),
                        CustomTextField(
                          startTimeController,
                          '09:00 AM',
                          const Icon(
                            Icons.keyboard_arrow_down,
                            color: Color(0xFF9747FF),
                          ),
                          MediaQuery.of(context).size.width / 2.5,
                          40,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'End time',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const Gap(7),
                        CustomTextField(
                          endTimeController,
                          '09:00 AM',
                          const Icon(
                            Icons.keyboard_arrow_down,
                            color: Color(0xFF9747FF),
                          ),
                          MediaQuery.of(context).size.width / 2.5,
                          40,
                        ),
                      ],
                    ),
                  ],
                ),
                const Gap(15),
                const Text(
                  'Priority',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                const Gap(7),
                Wrap(
                  children: List.generate(
                    priorities.length,
                    (int index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: ChoiceChip(
                          labelStyle: const TextStyle(fontSize: 12),
                          label: Text(
                            priorities[index],
                          ),
                          selected: true,
                          onSelected: (value) {},
                        ),
                      );
                    },
                  ).toList(),
                ),
                const Gap(15),
                const Text(
                  'Description',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                CustomTextField(
                  endTimeController,
                  'enter some description',
                  null,
                  double.infinity,
                  120,
                ),
                const Gap(15),
                Center(
                  child: Container(
                    height: 40,
                    width: 193,
                    decoration: const BoxDecoration(
                      color: Color(0xFF9747FF),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Create task',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        imgAdress: 'assets/images/createTodoBack.png',
      ),
    );
  }

  Container CustomTextField(TextEditingController controller, String? hintText,
      Widget? trailingIcon, double width, double height) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.only(left: 7, right: 5),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        border: Border.all(
          width: 1,
          color: const Color.fromARGB(255, 204, 203, 203),
        ),
      ),
      child: Center(
        child: TextField(
          controller: controller,
          maxLines: 4,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText ?? '',
            hintStyle: const TextStyle(fontSize: 15),
            suffixIcon: trailingIcon ?? null,
          ),
        ),
      ),
    );
  }
}
