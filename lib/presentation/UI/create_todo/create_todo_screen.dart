import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todoapp/bloc/cubit/selector_cubit.dart';
import 'package:todoapp/bloc/todo_bloc/bloc/todo_bloc.dart';
import 'package:todoapp/model/todo_model/todo_model.dart';
import 'package:todoapp/presentation/UI/home_screen/home_screen.dart';
import 'package:todoapp/presentation/widgets/custom_background.dart';
import 'package:todoapp/presentation/widgets/toast.dart';

class CreateTodoScreen extends HookWidget {
  const CreateTodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int _selectedChipIndex = 0;
    final titleController = useTextEditingController();

    final descriptionController = useTextEditingController();
    final dateTimeController = useTextEditingController();
    final startTimeController = useTextEditingController();
    final endTimeController = useTextEditingController();
    final  blocA = SelectorCubit();
    final  blocB = SelectorCubit();

    final options = [
      "Education",
      "Work",
      "Groceries",
    ];
    List<String> priorities = [
      "Low",
      "Medium",
      "High",
    ];
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
                      onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen())),
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
                  titleController,
                  'Enter title',
                  null,
                  double.infinity,
                  45,
                  () {},
                  false,
                ),
                const Gap(15),
                const Text(
                  'Category',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                const Gap(7),
                BlocProvider(
                  create: (context) => blocA,
                  child: BlocBuilder<SelectorCubit, int?>(
                    builder: (context, state) {
                      return Wrap(
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
                                selected: state == index,
                                onSelected: (value) {
                                  context
                                      .read<SelectorCubit>()
                                      .changeChoice(value, index);
                                },
                              ),
                            );
                          },
                        ).toList(),
                      );
                    },
                  ),
                ),
                const Gap(15),
                const Text(
                  'Date & Time',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                const Gap(7),
                CustomTextField(
                  dateTimeController,
                  '09 November, Wednesday',
                  SvgPicture.asset(
                    'assets/icons/calendar.svg',
                  ),
                  double.infinity,
                  45,
                  () async {
                    final result = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2050),
                    );
                    dateTimeController.text = result!.toString();
                  },
                  true,
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
                          '12:00 AM',
                          const Icon(
                            Icons.keyboard_arrow_down,
                            color: Color(0xFF9747FF),
                          ),
                          MediaQuery.of(context).size.width / 2.5,
                          45,
                          () async {
                            final result = await showTimePicker(
                              context: context,
                              initialTime:
                                  const TimeOfDay(hour: 00, minute: 00),
                            );
                            startTimeController.text =
                                result?.format(context) ??
                                    const TimeOfDay(hour: 00, minute: 00)
                                        .format(context);
                          },
                          true,
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
                          '12:00 AM',
                          const Icon(
                            Icons.keyboard_arrow_down,
                            color: Color(0xFF9747FF),
                          ),
                          MediaQuery.of(context).size.width / 2.5,
                          45,
                          () async {
                            final result = await showTimePicker(
                              context: context,
                              initialTime:
                                  const TimeOfDay(hour: 00, minute: 00),
                            );
                            endTimeController.text = result?.format(context) ??
                                TimeOfDay(hour: 00, minute: 00).format(context);
                          },
                          true,
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
                BlocProvider(
                  create: (context) => blocB,
                  child: BlocBuilder<SelectorCubit, int?>(
                    builder: (context, state) {
                      return Wrap(
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
                                selected: state == index,
                                onSelected: (selected) {
                                  context
                                      .read<SelectorCubit>()
                                      .changeChoice(selected, index);
                                },
                              ),
                            );
                          },
                        ).toList(),
                      );
                    },
                  ),
                ),
                const Gap(15),
                const Text(
                  'Description',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                CustomTextField(
                  descriptionController,
                  'Enter some description',
                  null,
                  double.infinity,
                  120,
                  () {},
                  false,
                ),
                const Gap(15),
                Center(
                  child: InkWell(
                    onTap: () {
                      TodoModel todo = TodoModel(
                        created_at: DateTime.now().toString(),
                        title: titleController.text.trim(),
                        description: descriptionController.text.trim(),
                        start_time: startTimeController.text.trim(),
                        end_time: endTimeController.text.trim(),
                        category:'work',
                        priority: 'low',
                        created_by:
                            Supabase.instance.client.auth.currentUser!.id,
                        do_day: dateTimeController.text.trim(),
                        is_completed: false,
                      );
                      context.read<TodoBloc>().add(TodoInsert(todo));
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const HomeScreen()));
                      // print('category tried ${BlocProvider.of<SelectorCubit>(context).state}');
                      // print('priority tried ${BlocProvider.of<SelectorCubit>(context).state}');
                    },
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
                ),
              ],
            ),
          ),
        ),
        imgAdress: 'assets/images/createTodoBack.png',
      ),
    );
  }

  Widget CustomTextField(
      TextEditingController controller,
      String? hintText,
      Widget? trailingIcon,
      double width,
      double height,
      void Function()? onTap,
      bool isReadOnly) {
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
          readOnly: isReadOnly,
          onTap: onTap,
          controller: controller,
          maxLines: 4,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText ?? '',
            hintStyle: const TextStyle(fontSize: 15, color: Colors.grey),
            suffixIcon: trailingIcon,
          ),
        ),
      ),
    );
  }
}
