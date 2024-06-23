import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:logger/web.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todoapp/bloc/todo_crud/bloc/todo_bloc.dart';
import 'package:todoapp/data/model/todo_model/todo_model.dart';
import 'package:todoapp/presentation/helper/hour_formatter.dart';
import 'package:todoapp/presentation/helper/index_helper.dart';
import 'package:todoapp/presentation/widgets/custom_background.dart';
import 'package:todoapp/presentation/widgets/toast.dart';
import 'package:todoapp/routes/go_router.dart';

class CreateTodoScreen extends StatefulWidget {
  const CreateTodoScreen({Key? key, this.todo}) : super(key: key);
  final TodoModel? todo;

  @override
  State<CreateTodoScreen> createState() => _CreateTodoScreenState();
}

class _CreateTodoScreenState extends State<CreateTodoScreen> {
  ValueNotifier<int?> _priorityIndex = ValueNotifier(null);
  ValueNotifier<int?> _categoryIndex = ValueNotifier(null);
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final dateTimeController = TextEditingController();
  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();
  final options = [
    "Dailytask",
    "Work",
    "Groceries",
    "Project",
  ];
  List<String> priorities = [
    "Low",
    "Medium",
    "High",
  ];

  @override
  void initState() {
    if (widget.todo != null) {
      final DateFormat dateFormatter = DateFormat('yyyy-MM-dd hh:mm');
      titleController.text = widget.todo!.title;
      descriptionController.text = widget.todo!.description;

      dateTimeController.text =
          dateFormatter.format(DateTime.parse(widget.todo!.created_at));
      startTimeController.text = widget.todo!.start_time;
      endTimeController.text = widget.todo!.end_time;
      _priorityIndex.value =
          checkIndex(widget.todo?.priority, i: 1, null, priorities);
      _categoryIndex.value =
          checkIndex(widget.todo?.category, options, null, i: 0);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Gap(50),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => context.pop(),
                      icon: const Icon(Icons.arrow_back_ios),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(20),
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
                    Wrap(
                      children: List.generate(
                        options.length,
                        (int index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: ValueListenableBuilder(
                                valueListenable: _categoryIndex,
                                builder: (context, value, child) {
                                  return ChoiceChip(
                                    labelStyle: const TextStyle(fontSize: 12),
                                    label: Text(
                                      options[index],
                                    ),
                                    selected: value == index,
                                    onSelected: (value) {
                                      _categoryIndex.value =
                                          value ? index : null;
                                    },
                                  );
                                }),
                          );
                        },
                      ).toList(),
                    ),
                    const Gap(15),
                    const Text(
                      'Date',
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
                        if (result != null) {
                          dateTimeController.text = result.toString();
                        }
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
                                  initialTime: startTimeController.text == null
                                      ? TimeOfDay.now()
                                      : const TimeOfDay(hour: 00, minute: 00),
                                );
                                if (result != null) {
                                  startTimeController.text = formatTime(result);
                                }
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
                                if (result != null) {
                                  endTimeController.text = formatTime(result);
                                }
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
                    Wrap(
                      children: List.generate(
                        priorities.length,
                        (int index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: ValueListenableBuilder(
                                valueListenable: _priorityIndex,
                                builder: (context, value, child) {
                                  return ChoiceChip(
                                    labelStyle: const TextStyle(fontSize: 12),
                                    label: Text(
                                      priorities[index],
                                    ),
                                    selected: value == index,
                                    onSelected: (selected) {
                                      _priorityIndex.value =
                                          selected ? index : null;
                                    },
                                  );
                                }),
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
                      descriptionController,
                      'Enter some description',
                      null,
                      double.infinity,
                      120,
                      () {},
                      false,
                    ),
                    const Gap(12),
                    Center(
                      child: InkWell(
                        onTap: () {
                          if (_categoryIndex.value == null || //groceries
                              _priorityIndex.value == null || // medium
                              titleController.text.isEmpty || // fuhf
                              dateTimeController.text.isEmpty || //
                              startTimeController
                                  .text.isEmpty || //2024-06-23 00:00:00.000
                              endTimeController.text.isEmpty || // 5: 35 AM

                              descriptionController.text.isEmpty) {
                            Toast().showToast(
                                'One of the fields is empty, Please fill them all!',
                                context);
                          } else {
                            TodoModel todo = TodoModel(
                              created_at: DateTime.now().toString(),
                              title: titleController.text.trim(),
                              description: descriptionController.text.trim(),
                              start_time: startTimeController.text.trim(),
                              end_time: endTimeController.text.trim(),
                              category:
                                  options[_categoryIndex.value!].toLowerCase(),
                              priority: priorities[_priorityIndex.value!]
                                  .toLowerCase(),
                              created_by:
                                  Supabase.instance.client.auth.currentUser!.id,
                              do_day: dateTimeController.text.trim(),
                              is_completed: false,
                            );
                            widget.todo != null
                                ? Toast().showToast(
                                    "This function is not implemented yet:(",
                                    context)
                                //context.read<TodoBloc>().add(TodoUpdate(todo))
                                : context
                                    .read<TodoBloc>()
                                    .add(TodoInsert(todo));
                            context.pop();
                            //    context.pushReplacementNamed(RouteNames.home.name);
                          }
                        },
                        child: Container(
                          height: 40,
                          width: 193,
                          margin: const EdgeInsets.only(bottom: 20),
                          decoration: const BoxDecoration(
                            color: Color(0xFF9747FF),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              widget.todo != null
                                  ? 'Update task'
                                  : 'Create task',
                              style: const TextStyle(
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
            ],
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
