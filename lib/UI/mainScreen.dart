import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/hive/database.dart';
import 'package:todoapp/model/note_model.dart';
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
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<NoteProvider>(context, listen: false);
    // var loadInfo = HiveDB().loadUser();
    var tasks = context.watch<NoteProvider>();
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: CustomerDrawer(),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          MasonryGridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 2,
              crossAxisSpacing: 2,
              itemCount: tasks.todos.length,
              itemBuilder: ((context, index) {
                return ItemContainer(
                    label: tasks.todos[index].title, mainText: ' mainText');
              })),
          AddButton(context),
        ],
      ),
    );
  }
}
