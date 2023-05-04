import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/hive/database.dart';
import 'package:todoapp/model/note_model.dart';
import 'package:todoapp/provider/Apptheme_provider.dart';
import 'package:todoapp/widgets/itemContainer.dart';
import '../widgets/addButton.dart';

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
      final auth = Provider.of<Database>(context, listen: false);
      auth.getItem();
    });
  }

  final editTitleController = TextEditingController();
  final editMainController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Database>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notes',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () =>
                Provider.of<AppTheme>(context, listen: false).toggleTheme(),
            icon: const Icon(Icons.ac_unit_sharp),
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ListView.builder(
            itemCount: provider.notes.length,
            itemBuilder: (context, index) {
              NoteModel data = provider.notes[index];
              return ItemContainer(
                label: data.title,
                mainText: data.mainText,
                onDeleted: () => provider.deleteItem(index),
                onEdit: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      editMainController.text = data.mainText;
                      editTitleController.text = data.title;

                      return AlertDialog(
                        title: const Text('Edit your note'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            TextField(
                              controller: editTitleController,
                              decoration: const InputDecoration(
                                labelText: 'Title',
                              ),
                            ),
                            TextField(
                              controller: editMainController,
                              decoration: const InputDecoration(
                                labelText: 'Main text',
                              ),
                            ),
                          ],
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Cancel'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              provider.updateItem(
                                index,
                                NoteModel(
                                    title: editTitleController.text,
                                    mainText: editMainController.text),
                              );

                              provider.getItem();
                              Navigator.of(context).pop();
                            },
                            child: const Text('Save'),
                          ),
                        ],
                      );
                    },
                  );
                },
              );
            },
          ),
          AddButton(context),
        ],
      ),
    );
  }
}
