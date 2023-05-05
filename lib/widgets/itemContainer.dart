// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import 'package:todoapp/constants/constants.dart';
import 'package:todoapp/Theme/Apptheme_provider.dart';

class ItemContainer extends StatelessWidget {
  String label;
  String mainText;
  VoidCallback onDeleted;
  void Function()? onEdit;

  ItemContainer({
    Key? key,
    required this.label,
    required this.mainText,
    required this.onDeleted,
    required this.onEdit,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context);
    return Stack(
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
            color: Colors.white.withOpacity(0.10),
            // color: Colors.white.withOpacity(0.15),
            blur: 8,
            elevation: 6,
            height: 240,
            padding: const EdgeInsets.all(10),
            child: Column(
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
                      style: const TextStyle(
                          color: Colors.white,
                          //TODO: comehere
                          // color: provider.themeMode == provider.isDarkMode
                          //     ? Colors.white
                          //     : const Color(0xFF484848),
                          fontSize: 15,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: onEdit,
                      icon: const Icon(Icons.edit),
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
