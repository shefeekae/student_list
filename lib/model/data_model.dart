// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:hive_flutter/hive_flutter.dart';
part 'data_model.g.dart';

@HiveType(typeId: 1)
class StudentModel {
  @HiveField(0)
  int? id;

  @HiveField(1)
  final name;

  @HiveField(2)
  final age;

  @HiveField(3)
  final studentId;

  @HiveField(4)
  final phone;

  StudentModel(
      {required this.name,
      required this.age,
      required this.studentId,
      required this.phone,
      this.id});
}
