import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.search,
            color: Colors.black,
            size: 30,
          ),
        ),
        IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
