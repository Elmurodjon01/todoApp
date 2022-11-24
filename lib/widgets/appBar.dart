import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/hive/themeManager.dart';
import 'package:todoapp/provider/noteProvider.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, value, child) {
        return AppBar(
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: Colors.black,
                size: 30,
              ),
            ),
            IconButton(
              onPressed: () {
                value.lightTheme;
                print('light');
              },
              icon: const Icon(
                Icons.more_vert,
                color: Colors.black,
              ),
            ),
            IconButton(
              onPressed: () {
                value.darkTheme;
                print('dark');
              },
              icon: const Icon(
                Icons.nightlight,
                color: Colors.black,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
