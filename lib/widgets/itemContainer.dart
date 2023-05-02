// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import 'package:todoapp/constants/constants.dart';

class ItemContainer extends StatelessWidget {
  String label;
  String mainText;
  VoidCallback onDeleted;

  ItemContainer({
    Key? key,
    required this.label,
    required this.mainText,
    required this.onDeleted,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Shimmer(
      duration: const Duration(seconds: 2),
      color: const Color.fromARGB(255, 107, 101, 101),
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Positioned(
            top: 200,
            left: 10,
            child: GradientBall(
              colors: [
                Color.fromARGB(255, 118, 223, 242),
                Colors.amber,
              ],
            ),
          ),
          const Positioned(
            top: 400,
            right: 10,
            child: GradientBall(
              size: Size.square(200),
              colors: [Colors.blue, Colors.purple],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlurryContainer(
              color: Colors.white.withOpacity(0.15),
              blur: 8,
              elevation: 6,
              height: 240,
              padding: const EdgeInsets.all(10),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        label,
                        style: kLabelStyle,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Expanded(
                    flex: 8,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 7,
                        right: 7,
                      ),
                      child: Text(
                        mainText,
                        style: kMainTextStyle,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Added to importants list'),
                            ),
                          );
                        },
                        icon: const Icon(Icons.star_outline),
                      ),
                      IconButton(
                        onPressed: onDeleted,
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GradientBall extends StatelessWidget {
  final List<Color> colors;
  final Size size;
  const GradientBall({
    Key? key,
    required this.colors,
    this.size = const Size.square(150),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height,
      width: size.width,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: colors,
        ),
      ),
    );
  }
}
