import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/model/note_model.dart';
import 'package:todoapp/provider/databaseProvider.dart';
import 'package:todoapp/widgets/itemContainer.dart';
import '../widgets/addButton.dart';
import '../widgets/drawer.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final provider = Provider.of<HiveDB>(context, listen: false);
      provider.loadTodo();
    });
  }

  @override
  Widget build(BuildContext context) {
    // var loadInfo = HiveDB().loadUser();
    final provider = Provider.of<HiveDB>(context);

    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          child: const Text(
            'call',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () => provider.loadTodo(),
        ),
      ),
      drawer: const CustomerDrawer(),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ListView.builder(
            itemCount: provider.notes.length,
            itemBuilder: (context, index) {
              var data = provider.notes;
              return ItemContainer(
                label: data[index].title,
                mainText: data[index].mainText,
                onDeleted: () {
                  provider.deleteTodo(index);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Todo is removed'),
                    ),
                  );
                },
              );
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
