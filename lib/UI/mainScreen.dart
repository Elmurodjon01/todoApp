import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/hive/database.dart';
import 'package:todoapp/model/note_model.dart';
import 'package:todoapp/provider/databaseProvider.dart';
import 'package:todoapp/provider/noteProvider.dart';
import 'package:todoapp/widgets/itemContainer.dart';
import '../widgets/addButton.dart';
import '../widgets/appBar.dart';
import '../widgets/drawer.dart';

class MainScreen extends StatefulWidget {
  MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late Box notesBox;
  @override
  void initState() {
    notesBox = Hive.box<NoteModel>('Notes');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var loadInfo = HiveDB().loadUser();

    return Scaffold(
      appBar: CustomAppBar(),
      drawer: CustomerDrawer(),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ValueListenableBuilder(
            valueListenable: notesBox.listenable(),
            builder: (BuildContext context, Box taskList, Widget? child) {
              if (notesBox.length > 0) {
                return MasonryGridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 2,
                    itemCount: notesBox.length,
                    itemBuilder: ((context, index) {
                      final data = notesBox.get(index);
                      if (data == null) {
                        return Center(
                          child: Text('no data'),
                        );
                      } else {
                        return ItemContainer(
                          label: data.title,
                          mainText: data.mainText,
                          onDeleted: () async {
                            await notesBox.deleteAt(index);
                            // tasks.deletTask(tasks.todos[index]);
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Note Deleted')));
                          },
                        );
                      }
                      //  var tasks = note.values.toList();
                    }));
              } else if (notesBox.isEmpty || notesBox == null) {
                return const Center(
                  child: Icon(
                    Icons.sentiment_dissatisfied,
                    size: 150,
                    color: Colors.black,
                  ),
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
          AddButton(context),
        ],
      ),
    );
  }
}
