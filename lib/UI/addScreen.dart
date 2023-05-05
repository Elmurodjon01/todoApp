import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/constants/constants.dart';
import 'package:todoapp/hive/database.dart';
import 'package:todoapp/model/note_model.dart';
import '../Theme/Apptheme_provider.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController mainTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Database>(context);
    final appTheme = Provider.of<ThemeProvider>(context);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
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
              // SizedBox(
              //   height: MediaQuery.of(context).size.height * 0.3,
              // ),
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
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: height / 18,
                            width: width / 3,
                            decoration: BoxDecoration(
                              //TODO:come here
                              // color: appTheme.currentTheme == appTheme.
                              //     ? Colors.grey
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Center(
                              child: Text(
                                'Cancel',
                                style: kLabelStyle,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (titleController.text.isNotEmpty) {
                              provider.addItem(
                                NoteModel(
                                    title: titleController.text,
                                    mainText: mainTextController.text),
                              );
                              provider.getItem();
                              titleController.clear();
                              mainTextController.clear();
                              Navigator.pop(context);
                            }
                          },
                          child: Container(
                            height: height / 18,
                            width: width / 3,
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              //TODO: come here
                              // color: appTheme.themeMode == appTheme.isDarkMode
                              //     ? Colors.grey
                              //     : Colors.orange,
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
