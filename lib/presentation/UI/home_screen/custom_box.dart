


import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomBox extends StatelessWidget {
  const CustomBox({
    super.key,
    required this.height,
    required this.width,
    required this.imgUrl,
    required this.title,
    required this.count,
    required this.backColor,
  });

  final double height;
  final double width;
  final String imgUrl;
  final String title;
  final int count;
  final Color backColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      height: height / 9,
      width: width / 2.45,
      decoration: BoxDecoration(
        color: backColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(9),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(
              bottom: 5,
              right: 10,
              left: 10,
            ),
            height: 33,
            width: 33,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(17),
            ),
            child: Center(
              child: SvgPicture.asset(
                imgUrl,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                count.toString(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
