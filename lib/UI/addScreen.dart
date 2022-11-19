import 'package:flutter/material.dart';
import 'package:todoapp/constants/constants.dart';

class AddScreen extends StatelessWidget {
  AddScreen({super.key});
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_ios),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: TextField(
                    controller: _controller,
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
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  width: width,
                  height: height / 2,
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: TextField(
                      autofocus: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: height / 18,
                  width: width / 3,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      'Save',
                      style: kLabelStyle,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
