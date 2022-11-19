import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:todoapp/widgets/itemContainer.dart';
import '../widgets/appBar.dart';
import '../widgets/drawer.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});
  List<String> labels = [
    'fnjnjdkf',
    'fdsnfksjd',
    'biwuebfgbf',
    'fbiewwf',
    'fnewkwe',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: CustomerDrawer(),
      body: Stack(
        children: [
          MasonryGridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 2,
            crossAxisSpacing: 2,
            itemCount: labels.length,
            itemBuilder: (context, index) {
              return ItemContainer(
                label: 'do assignment',
                mainText: 'due soon',
              );
              // return Tile(
              //   index: index,
              //   extent: (index % 5 + 1) * 100,
              // );
            },
          ),
        ],
      ),
    );
  }
}
