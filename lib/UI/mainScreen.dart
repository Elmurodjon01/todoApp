import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/model/note_model.dart';
import 'package:todoapp/provider/databaseProvider.dart';
import 'package:todoapp/widgets/itemContainer.dart';
import '../widgets/addButton.dart';
import '../widgets/appBar.dart';
import '../widgets/drawer.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  // void initState() {
  //   // notesBox = Hive.box<NoteModel>('Notes');
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    // var loadInfo = HiveDB().loadUser();
    final provider = Provider.of<HiveDB>(context);
    // var box = Hive.box('Notes');
    List<NoteModel> info = [];
    var data = provider.notes;
    Box box = Hive.box('Notes');
    var infoo = box.get('todos');

    data.add(infoo);

    return Scaffold(
      appBar: AppBar(),
      drawer: const CustomerDrawer(),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return ItemContainer(
                  label: data[index].title,
                  mainText: data[index].mainText,
                  onDeleted: () {});
            },
          ),
          // ListView.builder(
          //   itemCount: notes.,
          //   itemBuilder: (context, index) {
          //     final currentItem = provider.savedTodos[index];
          //     return ItemContainer(
          //         label: currentItem['title'].toString(),
          //         mainText: currentItem['mainText'].toString(),
          //         onDeleted: () {});
          //   },
          // ),
          // ValueListenableBuilder(
          //   valueListenable: notesBox.listenable(),
          //   builder: (BuildContext context, Box taskList, Widget? child) {
          //     if (notesBox.length > 0) {
          //       return MasonryGridView.count(
          //           crossAxisCount: 2,
          //           mainAxisSpacing: 2,
          //           crossAxisSpacing: 2,
          //           itemCount: notesBox.length,
          //           itemBuilder: ((context, index) {
          //             final data = notesBox.get(index);
          //             if (data == null) {
          //               return const Center(
          //                 child: Text(
          //                   'no data',
          //                   style: TextStyle(color: Colors.white),
          //                 ),
          //               );
          //             } else {
          //               return ItemContainer(
          //                 label: data.title,
          //                 mainText: data.mainText,
          //                 onDeleted: () async {
          //                   await notesBox.deleteAt(index);
          //                   // tasks.deletTask(tasks.todos[index]);
          //                   ScaffoldMessenger.of(context).showSnackBar(
          //                       SnackBar(content: Text('Note Deleted')));
          //                 },
          //               );
          //             }
          //             //  var tasks = note.values.toList();
          //           }));
          //     } else if (notesBox.isEmpty || notesBox == null) {
          //       return const Center(
          //         child: Icon(
          //           Icons.sentiment_dissatisfied,
          //           size: 150,
          //           color: Colors.black,
          //         ),
          //       );
          //     } else {
          //       return CircularProgressIndicator();
          //     }
          //   },
          // ),
          AddButton(context),
        ],
      ),
    );
  }
}
