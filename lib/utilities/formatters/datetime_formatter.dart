import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stokpile/constants/date_constants.dart';

DateTime dateFromFormattedString({required String date}) {
  //Expected format for date to be 'Sat, Apr 6, 2024'
  final splitDate = date.replaceAll(',', '').split(' ');

  final year = int.parse(splitDate[3]);
  final month = months[splitDate[1]]!;
  final day = int.parse(splitDate[2]);

  return DateTime(year, month, day);
}

TimeOfDay timeFromFormattedString({required String time}) {
  //Expected format for time to be '1:14 PM'
  final splitTime = time.split(':');
  final splitAmPm = splitTime[1].split(' ');

  int hour = int.parse(splitTime[0]);
  if (splitAmPm[1] == 'PM') {
    hour = hour + 12;
  } else {}
  final minute = int.parse(splitAmPm[0]);
  return TimeOfDay(hour: hour, minute: minute);
}

DateTime completeDateTimeFromDateAndTime(
    {required DateTime date, required TimeOfDay time}) {
  return DateTime(
    date.year,
    date.month,
    date.day,
    time.hour,
    time.minute,
  );
}

String toFancyFormattedDate({required DateTime date}) {
  final todayDay = DateTime.now().day;
  final todayMonth = DateTime.now().month;
  final todayYear = DateTime.now().year;

  if (date.day == todayDay &&
      date.month == todayMonth &&
      date.year == todayYear) {
    return 'Today @ ${DateFormat.jm().format(date)}';
  } else if (date.day == todayDay - 1 &&
      date.month == todayMonth &&
      date.year == todayYear) {
    return 'Yesterday @ ${DateFormat.jm().format(date)}';
  } else if (date.year == todayYear) {
    return DateFormat('E, MMM d').addPattern('@').add_jm().format(date);
  } else {
    return DateFormat('E, MMM d, y').addPattern('@').add_jm().format(date);
  }
}

String toFormattedDate({required DateTime date}) {
  return DateFormat.yMMMEd().format(date);
}

String timestampToFormattedDate({required Timestamp timestamp}) {
  return toFormattedDate(date: timestamp.toDate());
}

String timestampToFancyFormattedDate({required Timestamp timestamp}) {
  return toFancyFormattedDate(date: timestamp.toDate());
}

String toFormattedTime({DateTime? date, TimeOfDay? time}) {
  late DateTime result;
  if (time != null) {
    result = DateTime(
      2000,
      1,
      1,
      time.hour,
      time.minute,
    );
  } else if (date != null) {
    result = date;
  } else {
    return '';
  }
  return DateFormat.jm().format(result);
}
