import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/constants/constants.dart';
import 'package:todoapp/model/note_model.dart';
import 'package:todoapp/provider/databaseProvider.dart';
import 'package:todoapp/provider/noteProvider.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  // String title = '';
  // String mainText = '';
  // void onAdd() {}

  TextEditingController titleController = TextEditingController();
  TextEditingController mainTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<HiveDB>(context);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  // GestureDetector(
                  //   onTap: onAdd,
                  //   child: IconButton(
                  //     onPressed: () {},
                  //     icon: const Icon(Icons.arrow_back_ios),
                  //   ),
                  // ),
                  Container(
                    padding: const EdgeInsets.only(
                      left: 15,
                    ),
                    width: MediaQuery.of(context).size.width / 2,
                    child: TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Title',
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w700,
                            fontSize: 18),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.1,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.star_border_outlined),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.add_photo_alternate),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
              ),
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  SizedBox(
                    width: width,
                    height: height / 2,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: TextFormField(
                        maxLines: 20,
                        validator: (value) {
                          if (value == null) {
                            return 'The body cannot be empty';
                          }
                          return null;
                        },
                        controller: mainTextController,
                        autofocus: true,
                        decoration: const InputDecoration(
                          hintText: 'Type something here',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // final String textVal = taskTitleController.text;
                      // final bool completed = completedStatus;
                      if (titleController.text.isNotEmpty) {
                        // Provider.of<HiveDB>(context, listen: false).storeUser(todo);
                        // var box = Hive.box('Notes');
                        // box.put('title', title);
                        // box.put('mainText', mainText);
                        // Provider.of<NoteProvider>(context, listen: false).addTasks(todo);
                        provider.writeData(
                            titleController.text, mainTextController.text);
                        Navigator.pop(context);
                      }
                    },
                    child: Container(
                      height: height / 18,
                      width: width / 3,
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Center(
                        child: Text(
                          'Save',
                          style: kLabelStyle,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
