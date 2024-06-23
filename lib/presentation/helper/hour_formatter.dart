import 'package:flutter/material.dart';

String formatTime(TimeOfDay time) {
  String period = time.period == DayPeriod.am ? 'AM' : 'PM';
  int hour = time.hourOfPeriod;
  String minute = time.minute.toString().padLeft(2, '0');
  return '$hour:$minute $period';
}

TimeOfDay stringToTimeOfDay(String tod) {
  String newTod = tod.replaceAll(RegExp(r'[a-zA-Z]'), '');
  final format = newTod.split(":");

  final hour = int.parse(format[0]);

  final minute = int.parse(format[1]);
  return TimeOfDay(hour: hour, minute: minute);
}
