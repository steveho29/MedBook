import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Doctor {
  final String name, speciality, id;

  // Daily work time
  List<String> daily;

  // Weekly day usual work time, different with daily work time
  Map<int, List<String>?>? exceptWeekday;

  // Unsual day, can be off or have unusual work time
  // Map<DateTime, List<String>?> exceptDay;
  Map<DateTime, List<String>?>? exceptDay;
  // Usual off week day
  List<int>? get inactiveWeekday => exceptWeekday != null
      ? (exceptWeekday!.entries
          .where((entry) => entry.value!.isEmpty)
          .map((entry) => entry.key)
          .toList())
      : null;

  // Unusual off day
  List<DateTime>? get inactiveday => exceptDay != null
      ? (exceptDay!.entries
          .where((element) => element.value == null)
          .map((e) => e.key ).toList())
      : null;

  List<DateTime>? get acctiveExceptDay => exceptDay != null
      ? (exceptDay!.entries
          .where((element) => element.value != null)
          .map((e) => e.key ).toList())
      : null;
  
  List<String> availableTime (DateTime date) {
      if (exceptDay != null &&
          exceptDay!.containsKey(date)) {
        return exceptDay![date]!;
      }
      if (exceptWeekday != null &&
          exceptWeekday!.containsKey(date.weekday))
        return exceptWeekday![date.weekday]!;
      return daily.map((e) => e.toString()).toList();
  }
  void f() {
    // Map<dynamic, dynamic> json = {};

    // exceptWeekday = json.map(
    //   (key, value) => {
    //     int.parse(key.toString()): value != null
    //         ? (value as List<dynamic>).map((e) => e.toString()).toList()
    //         : null
    //   } as MapEntry<int, List<String>?>,
    // );
    // inactiveWeekday =
    //     (exceptWeekday.entries.where((entry) => entry.value == null))
    //         .map((entry) => int.parse(entry.key.toString()))
    //         .toList();

    //  inactiveday =
    //       (exceptWeekday.entries.where((entry) => entry.value == null))
    //           .map((entry) => (entry.key as Timestamp).toDate())
    //           .toList();
    List<Map<dynamic, dynamic>> json = [];
    Map<dynamic, dynamic> jsonday = {};
    Map<DateTime, List<String>?> day;
    day = {
      (jsonday['date'] as Timestamp).toDate(): jsonday['workTime'] != null
          ? (jsonday['workTime'] as List<dynamic>)
              .map((e) => e.toString())
              .toList()
          : null
    };

    List<Map<DateTime, List<String>?>> exceptDay = (json.map((e) => {
          (e['date'] as Timestamp).toDate(): e.containsKey('workTime')
              ? (e['workTime'] as List<dynamic>)
                  .map((e) => e.toString())
                  .toList()
              : null
        })).toList();
  }

  Doctor({
    required this.name,
    required this.speciality,
    required this.id,
    this.daily = const [],
    this.exceptDay = const {},
    this.exceptWeekday = const {},
  });
  Doctor.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        speciality = json['specialities'],
        id = json['id'],
        daily =
            (json['daily'] as List<dynamic>).map((x) => x.toString()).toList(),
        exceptWeekday = json['exceptWeekday'] != null
            ? (json['exceptWeekday'] as Map<dynamic, dynamic>?)!.map(
                (key, value) => new MapEntry(
                    int.parse(key.toString()),
                    value != null
                        ? (value as List<dynamic>)
                            .map((e) => e.toString())
                            .toList()
                        : null),
              )
            : null,
        exceptDay = json['exceptDay'] != null
            ? Map.fromIterable(json['exceptDay'] as List<dynamic>,
                key: (e) => (e['date'] as Timestamp).toDate(),
                value: (e) => e['workTime'] != null
                    ? (e['workTime'] as List<dynamic>)
                        .map((e) => e.toString())
                        .toList()
                    : null)
            : null;
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'speciality': speciality,
    };
  }
}
